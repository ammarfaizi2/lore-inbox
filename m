Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLXVet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTLXVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:34:49 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:5291 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S263880AbTLXVes convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:34:48 -0500
To: =?iso-8859-15?q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allow process or user to listen on priviledged ports?
References: <bscg1m$1eg$1@sea.gmane.org>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Wed, 24 Dec 2003 21:34:39 +0000
In-Reply-To: <bscg1m$1eg$1@sea.gmane.org> (
 =?iso-8859-15?q?Sven_K=F6hler's_message_of?= "Wed, 24 Dec 2003 17:43:09
 +0100")
Message-ID: <y2allp1c32o.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Köhler <skoehler@upb.de> writes:

> So is there any machanism to bind that permission (to listen on a
> priviledged tcp-port) to a specific user or a specific process?

Even if you can't find a way to do this, you can cheat: use an
iptables DNAT rule to translate connections to the desired port into
connections to a non-privileged port upon which your daemon is
actually listening. Something like:

iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 1.2.3.4:8080

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
