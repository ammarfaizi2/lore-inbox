Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTLXWBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLXWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:01:50 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:55201 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S263937AbTLXWAT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:00:19 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: allow process or user to listen on priviledged ports?
Date: Wed, 24 Dec 2003 16:00:16 -0600
User-Agent: KMail/1.5.94
References: <bscg1m$1eg$1@sea.gmane.org> <y2allp1c32o.fsf@cartman.at.fivegeeks.net>
In-Reply-To: <y2allp1c32o.fsf@cartman.at.fivegeeks.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312241600.16035.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 03:34 pm, Adam Sampson wrote:
> Sven Köhler <skoehler@upb.de> writes:
> > So is there any machanism to bind that permission (to listen on a
> > priviledged tcp-port) to a specific user or a specific process?
>
> Even if you can't find a way to do this, you can cheat: use an
> iptables DNAT rule to translate connections to the desired port into
> connections to a non-privileged port upon which your daemon is
> actually listening. Something like:
>
> iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 1.2.3.4:8080
 Not to be too picky, but I think the redirect target is better suited for 
this. I haven't seen the source, but I assume it will be more efficient 
because it knows the destination is the local machine. 
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 22
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
