Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUDEP5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDEP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:57:14 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:11505 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262904AbUDEP5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:57:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Carlos Fernandez Sanz <cfs-lk@nisupu.com>,
       Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 3com issues in 2.6.5
Date: Mon, 5 Apr 2004 11:57:08 -0400
User-Agent: KMail/1.6
References: <003301c41b18$38ff7f90$1530a8c0@HUSH> <000401c41b1f$d2cf65c0$1530a8c0@HUSH> <20040405152834.GA11853@carfax.org.uk>
In-Reply-To: <20040405152834.GA11853@carfax.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404051157.08567.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.9.48] at Mon, 5 Apr 2004 10:57:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 April 2004 11:28, Hugo Mills wrote:
>On Mon, Apr 05, 2004 at 05:08:16PM +0200, Carlos Fernandez Sanz 
wrote:
>> > > module with both interfaces up, but obviously as soon as I do
>> > > that they dissapear - I assume this is the intended 2.6
>> > > behaviour).
>> >
>> > Let me ask you, are you noticing slowness sending or receiving? 
>> > I'm
>>
>> having
>>
>> Yes, this is why I started to look at the problem.
>> (slow as in 100 kb/s in a 100 Mbit/s LAN).
>
>   I'm reasonably certain that there's something wrong somewhere
> with the 2.6 network subsystem. I've been getting _very_ slow
> network performance with a PCI natsemi card -- characterised by
> repeated netdev watchdog timeouts under any load heavier than an
> ssh terminal session.
>
>   Hugo.

I'd be more inclined to blame it on the card driver, Hugo. I have a 
nightly rsync session that scans and updates a mirror of several 
partitions on my firewall box to a disk in this box, and it hasn't 
generated any error messages yet, over about 20 2.6.x kernels, 
currently running 2.6.5.  I get an 100% normal email from rsync every 
night, but no errors are being logged.  Its a 100base T network, 
driver 8139too on this end, an 8129 based card on the other end, and 
with an old (I think, its been 6 years) dlink FA-310 (ne2k-pci) on 
the other card serveing the dsl connection.

The firewall itself is connected to the dsl thru a second 10-baseT 
card and a router with the firewall connecting the 2 cards.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
