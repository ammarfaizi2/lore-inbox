Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVFMMus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVFMMus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVFMMus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:50:48 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:38296 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261545AbVFMMun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:50:43 -0400
Message-ID: <00cf01c5701d$e1c00ef0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <Pine.LNX.4.61.0506131436180.1658@yvahk01.tjqt.qr>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 09:43:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are free to, but I've rarely(never?) seen GCC actually do it with the
default build setup.  Don't trust me - look at a generated ASM listing and
convince yourself what I'm saying is true.  GCC does a lot of massive
reordering within functions though.

Throw a "CFLAGS += -Wa,-al=$<.lst" at the top of the Makefile.  That'll
generate a "process.c.lst" assembler listing file.

IAC, it would be harmless if one did, and goodness if one doesn't.  That
sounds like a win to me :)

 Tony

----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
>
> C compilers are free to reorder functions (are they?), especially GCC when
it
> is passed -funit-at-a-time (which currently is not in CFLAGS).


