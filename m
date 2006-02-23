Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWBWRdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWBWRdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWBWRdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:33:15 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:15108 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S932098AbWBWRdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:33:13 -0500
Date: Thu, 23 Feb 2006 17:32:16 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paul Mackerras <paulus@samba.org>, klibc@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
Message-ID: <20060223173216.GA20322@linux-mips.org>
References: <43FCDB8A.5060100@zytor.com> <17405.9318.991684.872546@cargo.ozlabs.ibm.com> <43FD2D96.7030600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FD2D96.7030600@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 07:35:50PM -0800, H. Peter Anvin wrote:

> This is what I've found so far: (64-bit architectures excluded)
> 
> 	arm		- N/A (PAGE_SHIFT == 12)
> 	arm26		- MMAP2_PAGE_SHIFT == 12
> 	cris		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (13)
> 	frv		- MMAP2_PAGE_SHIFT == 12
> 	h8300		- N/A (PAGE_SHIFT == 12)
> 	i386		- N/A (PAGE_SHIFT == 12)
> 	m32r		- N/A (PAGE_SHIFT == 12)
> 	m68k		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (variable)
> 	mips		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (variable)

A variable which happens to be fixed to 12 in practice.  As explained by
Ben the API is only relevant to 32-bit kernels and afaik PAGE_SHIFT
other than 12 has only been successfully been tested on 64-bit kernels.

  Ralf
