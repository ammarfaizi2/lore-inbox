Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbTCUOpn>; Fri, 21 Mar 2003 09:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263631AbTCUOpm>; Fri, 21 Mar 2003 09:45:42 -0500
Received: from amdext2.amd.com ([163.181.251.1]:27351 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S263630AbTCUOpm>;
	Fri, 21 Mar 2003 09:45:42 -0500
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B2E@txexmtae.amd.com>
From: ravikumar.chakaravarthy@amd.com
To: hpa@zytor.com
cc: linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Fri, 21 Mar 2003 08:56:25 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1265F7AC774846-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way I can get away with this error? What changes would I have to make??



-Ravi

-----Original Message-----
From: H. Peter Anvin [mailto:hpa@zytor.com] 
Sent: Thursday, March 20, 2003 5:07 PM
To: Chakaravarthy, Ravikumar
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loading and executing kernel from a non-standard address usin g SY SLINUX

ravikumar.chakaravarthy@amd.com wrote:
> I tweaked the SYSLINUX boot loader and kernel to load and execute the kernel from 0x200000 (physical address). However when I try to load the kernel using the SYSLINUX bootloader to an address 0xdf000000(physical address) it doesn't work!!
> I want to know if the following should work.
> 
> 1. Should the syslinux be able to copy to the address DI=(0xdf000000). I think bcopy  function in (SYSLINUX sources) does this.. Though the bcopy is done in the 32-bit mode, SOMETIMES it fails for this physical address). bcopy is called in runkernel.inc.

Yes.

> 2. Will I have any problem in the setup.S code in arch/i386/boot or head.S in arch/i386/boot/compressed because of this copy to 0xdf000000?? At times when it gets past step 1, it fails in malloc in arch/i386/boot/compressed/misc.c. The error it gives in "Memory Error"

Almost certainly.

	-hpa



