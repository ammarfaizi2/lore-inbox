Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFMPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFMPLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVFMPLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:11:11 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:25850 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261603AbVFMPIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:08:47 -0400
Message-ID: <008201c57031$2be937a0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <200506131618.09718.vda@ilport.com.ua> <000e01c57028$c82dba90$2800000a@pc365dualp2> <200506131726.50264.vda@ilport.com.ua>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 12:01:28 -0400
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

----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
>
> I am not affected. I compile my kernels with zero alignment.
>
> Not my itch to scratch.

Does some clueless user who needs a custom kernel for something even
understand what you just said?  Probably not...

>
> Do you realize how large linux kernel is? Are you going to optimize all of
it
> by hand?!

Its big, but not as big as some I've worked on.  I'm willing to tune the
"arch" specific stuff where I can do better than the compiler.  A few bytes
here, a few there, pretty soon you got a page back.  BTW, there's just under
100K of fluff zero padding in locked pages because of the way kernel
messages are being 32 byte aligned.  Do you think getting 100K of locked
kernel memory back essentially "for free" is worth taking a shot at?  I do.

>
> People tend to gradually update their systems. Make gcc better, and it
will
> pay back with time. If you want that benefit _now_, then use your better
gcc
> immediately instead of stone age one. Others will take care of themselves.
>
Pretty harsh attitude IMO.  People use compilers because they DO want
someone to take care of some things for them.

