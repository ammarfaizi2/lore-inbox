Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263125AbTCTW5A>; Thu, 20 Mar 2003 17:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbTCTW5A>; Thu, 20 Mar 2003 17:57:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263125AbTCTW44>; Thu, 20 Mar 2003 17:56:56 -0500
Message-ID: <3E7A49A6.5000908@zytor.com>
Date: Thu, 20 Mar 2003 15:07:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: ravikumar.chakaravarthy@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Loading and executing kernel from a non-standard address usin
 g SY SLINUX
References: <99F2150714F93F448942F9A9F112634CA54B2D@txexmtae.amd.com>
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B2D@txexmtae.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ravikumar.chakaravarthy@amd.com wrote:
> I tweaked the SYSLINUX boot loader and kernel to load and execute the kernel from 0x200000 (physical address). However when I try to load the kernel using the SYSLINUX bootloader to an address 0xdf000000(physical address) it doesn't work!!
> I want to know if the following should work.
> 
> 1. Should the syslinux be able to copy to the address DI=(0xdf000000). I think bcopy  function in (SYSLINUX sources) does this.. Though the bcopy is done in the 32-bit mode, SOMETIMES it fails for this physical address). bcopy is called in runkernel.inc.

Yes.

> 2. Will I have any problem in the setup.S code in arch/i386/boot or head.S in arch/i386/boot/compressed because of this copy to 0xdf000000?? At times when it gets past step 1, it fails in malloc in arch/i386/boot/compressed/misc.c. The error it gives in "Memory Error"

Almost certainly.

	-hpa


