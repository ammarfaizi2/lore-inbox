Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSGLTyN>; Fri, 12 Jul 2002 15:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSGLTyM>; Fri, 12 Jul 2002 15:54:12 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:55786 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316825AbSGLTyJ>; Fri, 12 Jul 2002 15:54:09 -0400
Date: Fri, 12 Jul 2002 21:55:26 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207121955.g6CJtQur018433@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
>work regardless,

Wis you ever look at the cdrecord sources?

Cdrecord relies on libscg which is a generic SCSI transport library.
It has been first written in August 1986 when I wrote the first SCSI
pass through driver (for SunOS-3.0) - long before Adapted came out with
ASPI. In the 16 years of evolution, it has been ported to > 30
different platforms (not including CPU variants like sparc/x86).

If you force cdrecord to rely on CD-ROM only interfaces, you make Linux
unusable in general. Do you really like to create an unusable Linux just
to avoid creating a usable generic SCSI transport interface?
Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
