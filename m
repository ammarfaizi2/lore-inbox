Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUBLUEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUBLUEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:04:33 -0500
Received: from web21206.mail.yahoo.com ([216.136.175.8]:59041 "HELO
	web21206.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266588AbUBLUEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:04:31 -0500
Message-ID: <20040212200428.92334.qmail@web21206.mail.yahoo.com>
Date: Thu, 12 Feb 2004 12:04:28 -0800 (PST)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: Re: Strange boot with multiple identical disks 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402121938.i1CJcpVb002430@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:
> On Thu, 12 Feb 2004 11:28:48 PST, Konstantin Kudin
> <konstantin_kudin@yahoo.com>  said:
> 
> >  Now I am trying to add the failing one as /hdc,
> and
> > boot. Linux starts to display all kinds of weird
> > messages, and thinks that / partition was shut
> down
> > uncleanly. I just hit "reset". Then I disable /hdc
> via
> > the boot option hdc=noprobe, and things boot fine.
> If
> > I try to disable raid via raid=noautodetect, the
> bunch
> > of errors still appears and the boot is no go.
> Done
> > this several times, without /hdc things are fine,
> with
> > - all kinds of issues.
> > 
> >  What is the problem for linux to boot on /hda
> when
> > /hdc is detected and has almost identical setup? 
> 
> Sometimes, the LABEL= support is your enemy.  You
> probably have
> multiple partitions with the same LABEL=, and your
> /etc/fstab is
> picking up the "wrong" ones.  Try giving partition
> names instead.

 Thanks for the tips! At first I tried to correct
/etc/fstab (replaced LABEL=/ by /dev/hda6), but still
got the problem. Then I also edited /etc/grub.conf and
replaced LABEL by the device there, and things boot
fine now.
 
 Konstantin
 

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
