Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSDESaw>; Fri, 5 Apr 2002 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDESam>; Fri, 5 Apr 2002 13:30:42 -0500
Received: from cannabis.daphnes.RO ([194.105.18.252]:34060 "HELO
	cannabis.daphnes.ro") by vger.kernel.org with SMTP
	id <S313392AbSDESae>; Fri, 5 Apr 2002 13:30:34 -0500
Date: Fri, 5 Apr 2002 21:29:44 +0300 (EEST)
From: halfdead <halfdead@daphnes.ro>
X-X-Sender: <halfdead@daphnes.ro>
To: <linux-kernel@vger.kernel.org>
Subject: weird IDT issue
Message-ID: <Pine.LNX.4.33.0204052125250.15770-100000@daphnes.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey! i experience a weird IDT issue on kernels 2.4.x. what i want to do is
finding the address of a certain IDT gate but when i try to read memory
from ring0 at that location it segfaults. the code is in assembler.

.bss
idtr:
.double
.text

get_gate:
	movl	$0x80, %eax
	sidt	idtr
	movl	idtr+2, %ebx
	leal	(%ebx, %eax, 8), %ebx
	movw	(%ebx), %cx 	<- segfault

i cannot find out why is this happening.. i would apreciate any help that
i can get.

- halfdead

