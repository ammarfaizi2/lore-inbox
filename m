Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSGPOFj>; Tue, 16 Jul 2002 10:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317850AbSGPOFi>; Tue, 16 Jul 2002 10:05:38 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:57569 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317842AbSGPOFg>; Tue, 16 Jul 2002 10:05:36 -0400
Date: Tue, 16 Jul 2002 16:06:55 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161406.g6GE6tYh021918@burner.fokus.gmd.de>
To: James.Bottomley@steeleye.com, lmb@suse.de, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From lars@marowsky-bree.de Tue Jul 16 13:45:59 2002

>> Why should the character interface be connected to the block layer?
>> This would contradict UNIX rules.

>How would it? At some layer, the two are merged anyway (for example, at least
>on disk you'll have blocks again). Doing it up high means more unified code
>below.

Just a hint: the block layer is for caching blocks from disk type deveices.

-	Block device access is always going directly into the block cache.
	So the I/O is always kernel I/O. In addition, it is async I/O - the 
	block layer fires it up and may wait for it later after sending out other
	requests.

-	Character device access is synchronous access and may be either kernel
	or user space DMA access. In most cases, it is user space DMA access.

How try to ask your question again...


>> AFAIK, tagged command queuing is a SCSI specific property, why should this
>> be part of a generif block layer?

>That is not true. Late IDE also has this, and systems like drbd - which
>currently uses a quite clever heuristic to deduce barriers - could also
>utilize this input.

How is it implemented?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
