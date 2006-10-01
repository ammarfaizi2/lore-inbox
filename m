Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752027AbWJAGDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWJAGDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 02:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWJAGDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 02:03:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752027AbWJAGDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 02:03:06 -0400
Date: Sat, 30 Sep 2006 23:02:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chris Lee" <labmonkey42@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       <linux-scsi@vger.kernel.org>, <Neela.Kolli@engenio.com>
Subject: Re: Problem with legacy megaraid
Message-Id: <20060930230259.497b7bc9.akpm@osdl.org>
In-Reply-To: <451f5496.40cc4d00.1456.ffffef37@mx.gmail.com>
References: <20060930155410.8238c195.akpm@osdl.org>
	<451f5496.40cc4d00.1456.ffffef37@mx.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 00:39:37 -0500
"Chris Lee" <labmonkey42@gmail.com> wrote:

> Thanks for your response Andrew.  Comment responses in-line:
> 
> > 
> > > I am not subscribed to this list.  Please CC me on replies.
> > 
> > (more cc's added)
> > 
> 
> Outstanding; thank you.
> 
> > > I have a machine I'm trying to use as a file server.  I 
> > have a RAID10 and a
> > > RAID5 on a single Dell PERC2/DC (AMI Megaraid 467) 
> > controller.  Both arrays
> > > are also on the same SCSI channel.  The system runs fine 
> > for days on end
> > > until I put some heavy I/O load on either array and sustain 
> > it for a few
> > > seconds.
> > 
> > We recently discovered that "The old megaraid driver is 
> > apparently borken
> > for firmware newer than 6.61.".  So please check that and see if a
> > downgrade is needed.
> > 
> 
> The Dell firmware version on the card currently is 1.06.  I have not found a
> newer firmware version than that one.
> 
> > Is there some reason why you cannot use the new megaraid driver?
> > 
> 
> The config help for the megaraid drivers suggested that the new megaraid
> driver would not support a PERC2.  I had enabled both drivers in the kernel
> which is having this problem.:
> 
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=y
> CONFIG_MEGARAID_MAILBOX=y
> CONFIG_MEGARAID_LEGACY=y
> 
> After your suggestion I rebuilt the kernel with legacy disabled.:
> 
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=y
> CONFIG_MEGARAID_MAILBOX=y
> # CONFIG_MEGARAID_LEGACY is not set
> 
> The new megaraid driver does not detect the PERC2/DC just as I feared it
> would not.  Unless I'm missing some kernel commandline arguments necessary
> to make the new driver find the card, I'm stuck with legacy.

Oh well.  I was just guessing - I've never even seen a megaraid controller,
sorry.

> > 
> > > Distro: Gentoo Linux
> > > Kernel: 2.6.17-gentoo-r7
> > > 
> > > Hardware:
> > > Motherboard: Tyan Thunder i7501 Pro (S2721-533)
> > > CPUs: Dual 2.8Ghz P4 HT Xeons
> > > RAM: 4GB registered (3/1 split, flat model)
> > > RAID: Dell PERC2/DC (AMI Megaraid 467)
> > > SCSI: Adaptec AHA-2940U2/U2W PCI
> > > NICs: onboard e100 and dual onboard e1000
> > > 

Did it work correctly under any earlier kernel version?  If so, which?
