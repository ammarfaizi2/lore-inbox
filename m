Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267654AbUHELv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267654AbUHELv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267652AbUHELv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:51:58 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:29615 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267657AbUHELv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:51:27 -0400
Date: Thu, 5 Aug 2004 13:50:50 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051150.i75Boon7004321@burner.fokus.fraunhofer.de>
To: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Cc: schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>

>I've written a patch for cdrecord/cdrtools. I've sent it to Joerg Schilling
>already, but got no answer so far. Probably he's on vaccation.

Looks like I first need to correct you :-(

You send a mail on July 5th and received a reply on July 6th, wo where is
your problem?


>I'm sending this to LKML too, because I've read about some ... nebulosity
>with respect to scsi device numbering as used by cdrtools.

This is caused by the "mist" throughn out by parts of the Linux kernel :-(


>To cut a long story short: the patch avoids cdrecord having to use the
>"virtual" scsi device numbering in the form of "ATAPI:x.y.z" and allows
>you to use the name of the device, e.g. /dev/hdc instead.

I am sorry, but using something like dev=/dev/hdc is deprecated.
In addition, several programs distinct between so called Cooked ioctl()s and
generic SCSI by checking for UNIX device names vs. SCSI address specs.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
