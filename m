Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbRDMWIh>; Fri, 13 Apr 2001 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDMWI1>; Fri, 13 Apr 2001 18:08:27 -0400
Received: from gear.torque.net ([204.138.244.1]:1552 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131976AbRDMWIN>;
	Fri, 13 Apr 2001 18:08:13 -0400
Message-ID: <3AD778AE.F80C8956@torque.net>
Date: Fri, 13 Apr 2001 18:07:42 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org, Matt Domsch <Matt_Domsch@Dell.com>
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <Matt_Domsch@Dell.com> wrote:
> I'm working on an IA-64 user-space application to add a Linux entry to
> the IA-64 boot manager.  To do so, I've got to uniquely identify a
> disk by it's controller PCI address, SCSI channel,
> ID, and LUN.  Essentially, I need to tie /dev/sda to an EFI device.  An
> equivalent problem (with similar solution) exists with i386 where the
> BIOS boot order is not necessarily the Linux driver load order.
> 
> 
> BIOS Enhanced Disk Drive Services 3.0 provides a way to query BIOS for
> what it thinks is it's device location and order.  IA-64 implements
> EDD 3.0, and some i386 BIOS manufactures are adding this feature
> also.  EDD 3.0 information is available at http://www.t13.org.
> 
> What I'd like to do is add the PCI location of the SCSI controller to
> the information printed in /proc/scsi/scsi, as follows:
> 
> Attached devices:
> Host: scsi0 Channel: 00 Id: 05 Lun: 00 PCI bus: 1 slot: 6 fn: 0
>   Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
>   Type:   CD-ROM                           ANSI SCSI revision: 02

[snip]

Matt,
SANE (and probably some other applications) parses the
output of 'cat /proc/scsi/scsi' so any change to its
format may trip SANE up. How about another entry in
the /proc/scsi directory that has a more parsable format
(e.g. xml :-) ).

Also ISA adapters are not the only non-PCI adapters,
there are the growing band of pseudo adapters that
may or may not have a PCI bus at the bottom of some
other protocol stack.

Doug Gilbert
