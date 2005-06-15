Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVFOXSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVFOXSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVFOXR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:17:26 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:54467 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261666AbVFOXPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:15:09 -0400
Message-ID: <000201c57207$72016a00$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <7eggert@gmx.de>, "Gene Heskett" <gene.heskett@verizon.net>,
       <linux-kernel@vger.kernel.org>
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it> <E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
Subject: Re: .../asm-i386/bitops.h  performance improvements
Date: Wed, 15 Jun 2005 19:53:27 -0400
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

Ummm, in simple terms - this statement is flat out 100% wrong.

LEA with the SIB byte has been around since 386 and is included on every CPU
Linux is capable of running on.

Compile this using -m386 and look at the ASM listing file and convince
yourself.

unsigned int foo(int bar)
{
return ((bar<<3)+bar);
}

GCC is going to generate a MOV of parm to EAX, then a LEA EAX,[EAX+EAX*8]

Don't trust me - compile this and prove it to yourself.


----- Original Message ----- 
From: "Bodo Eggert" <harvested.in.lkml@posting.7eggert.dyndns.org>
To: "Gene Heskett" <gene.heskett@verizon.net>; <cutaway@bellsouth.net>;
<linux->
>
> However, the multiplicator is not documented for i486, therefore it will
be a i586
> extension.

