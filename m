Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315621AbSECJep>; Fri, 3 May 2002 05:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315622AbSECJeo>; Fri, 3 May 2002 05:34:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46095 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315621AbSECJeo>; Fri, 3 May 2002 05:34:44 -0400
Message-Id: <200205030931.g439VEX09418@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Date: Fri, 3 May 2002 13:35:08 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <5.1.0.14.2.20020502094535.04261b70@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 May 2002 06:49, Anton Altaparmakov wrote:
> >And I recently moved my /usr/src to separate partition.
> >That is, /usr/src is now a mount point.
> >I have to export it in NFS exports *and* mount it *on every workstation*
> >(potentially thousands of wks!).
>
> Yes, edit /etc/fstab. My file server has loads of partitions and it exports
> them all and /etc/fstab on all clients just mounts them all. Problem being?

Problem is that I have to modify /etc/fstab on every workstation.

> >I'll repeat myself. What if some advanced fs has no sensible way of
> >generating inode? Does it have to 'fake' it, just like [v]fat does it now?
> >(Yes, vfat is not 'advanced' fs, let's not discuss it...)
>
> They have to fake it yes. Otherwise all existing userspace utilities will
> break. And no they cannot be changed otherwise they would no longer work
> on non-Linux platforms and most utilities are UNIX utilities which work on
> everything including Linux. You don't want to break that.

It seems to me like the Bad Thing which is too old and traditional to change.
:-(

> That would break UNIX semantics. Which it seems is exactly what you want to
> do... I don't think you will find many supporters of that idea... As Linus
> pointed out to me the inode is the basic i/o entity in UNIX and hence
> Linux. And that is not going to change...

Yes, it isn't going to change.
--
vda
