Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVCXKMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVCXKMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVCXKMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:12:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263081AbVCXKMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:12:07 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Arjan van de Ven <arjan@infradead.org>
To: Asfand Yar Qazi <ay1204@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42428FCE.7070901@qazi.f2s.com>
References: <3LwFC-4Ko-15@gated-at.bofh.it> <3LwYW-4Xx-11@gated-at.bofh.it>
	 <3LwYZ-4Xx-25@gated-at.bofh.it>  <42428FCE.7070901@qazi.f2s.com>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 11:11:58 +0100
Message-Id: <1111659118.6290.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 10:00 +0000, Asfand Yar Qazi wrote:
> Arjan van de Ven wrote:
> >>* "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
> >>it in any case.
> >>
> > 
> > 
> > probably just one of those things implemented in the binary drivers in
> > software, just like the "hardware" IDE raid is most of the time (3ware
> > being the positive exception there)
> > 
> 
> http://www.neoseeker.com/Articles/Hardware/Previews/nvnforce4/3.html
> 
> You're right there - some semi-hardware support combined with drivers 
> apparently result in lower CPU usage that software firewalls.  Apparently.

lower CPU usage than the *windows* firewall.
While there is a potential gain from a firewall function on the other
side of the PCI bus, this gain is when you reject most packets. Eg you
save "bad" packets from going over the bus. Now the question is how many
bad packets do you get per second...

> However one feature that you can't laugh at is the fact that it can be 
> made to block packets in the span of time between the OS being loaded 
> up, and the "real" firewall coming up.  This small time span 
> theoretically leaves the PC vulnerable, so I think this is the only 
> use for "ActiveAmor Firewall".

This is a joke right? In linux at least, the OS doesn't get packets
unless it asks for it; I can't imagine any other OS doing that
differently (since most are somewhat based on the same model). And all
linux distros I know of first install the firewall rules and then tell
the NIC to start receiving packets. In that order. I don't know how
windows does it (and I don't care), but if it gets this wrong it would
be a really bad bug in windows. But I guess it'd give the chipset
marketing people something to boast about ;)


