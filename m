Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUHIRyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUHIRyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUHIRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:54:36 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:56499 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266798AbUHIRyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:54:25 -0400
Date: Mon, 9 Aug 2004 19:53:42 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091753.i79Hrg9q010822@burner.fokus.fraunhofer.de>
To: axboe@suse.de, noah@cs.caltech.edu
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: [PATCH] Make scsi.h nominally userspace-clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de  Mon Aug  9 19:52:11 2004

>> scsi/scsi.h does not compile cleanly in userspace programs due to its
>> use of ``u8''.  I have confirmed this bug and prepared and tested a
>> fix that simply changes all such uses to ``__u8''.  Please consider
>> for inclusion.
>> 
>> I do not argue that including this header file in a program is
>> appropriate, but other kernel headers already take as many precautions
>> as this patch introduces.  I chose __u8 over uint8_t as more in the
>> style of the kernel generally.
>> 
>> Please keep me on cc:; I do not subscribe to the lists.

>I already sent such a patch to Linus.

thank you! Did you also send a patch for sg.h to include linux/compiler.h?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
