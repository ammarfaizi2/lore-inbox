Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbULOAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbULOAsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULOAoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:44:02 -0500
Received: from levante.wiggy.net ([195.85.225.139]:18639 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261791AbULOAnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:43:10 -0500
Date: Wed, 15 Dec 2004 01:43:04 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Adam Denenberg <adam@dberg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
Message-ID: <20041215004303.GC6623@wiggy.net>
Mail-Followup-To: Adam Denenberg <adam@dberg.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr> <1103045881.10965.48.camel@sucka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103045881.10965.48.camel@sucka>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Adam Denenberg wrote:
> i am aware that UDP is connectionless.  However in terms of a firewall
> this is different.  It _must_ keep a state table of some sorts otherwise
> high port outbound connections destined for a DNS server will never be
> let back in b/c the firewall will just say "Why is this dns server
> making a udp connection to port 32768 on this client?".  Keeping a state
> table allows this behavior thru the firewall as it should.

Just allow outgoing udp traffic from source port 53 from your DNS
server and you're done. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
