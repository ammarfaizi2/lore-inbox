Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269435AbTCDRYs>; Tue, 4 Mar 2003 12:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269441AbTCDRYs>; Tue, 4 Mar 2003 12:24:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30154 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269435AbTCDRYr>; Tue, 4 Mar 2003 12:24:47 -0500
Date: Tue, 04 Mar 2003 09:34:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ravikumar.chakaravarthy@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Loading and executing kernel from a non-standard address using
 SY SLINUX
Message-ID: <124790000.1046799286@[10.10.2.4]>
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
References: <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to load and boot the kernel from a non-standard address
> (0x200000). I am using the SYSLINUX boot loader, which loads the
> kernel at that address. I have also made changes to the kernel to
> setup code and startup_32() function to effect the same. When I boot
> the system It says
> 
> Loading.......... Ready
> Uncompressing Linux... OK Booting the kernel
> 
> and then hangs.
> 
> I guess the reason being the System.map entries are still using the
> PAGE_OFFSET = 0xc0000000, as opposed to 0xc0100000.
> I have the following questions??
> 
> 1. How do i change the System.map to get the right PAGE_OFFSET.
> 2. Will it work if I load and boot the kernel from a different address
> like (0xdf000000)??
> 
> 3. Am I in the right track or missing something.

The kernel should decompress itself to the right space anyway ... check
arch/i386/boot/compressed/head.S ... should be minimal changes needed,
if any.

M.

