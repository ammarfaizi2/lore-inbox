Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWH3Q4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWH3Q4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWH3Q4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:56:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46985 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751077AbWH3Q4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:56:20 -0400
From: Andi Kleen <ak@suse.de>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Date: Wed, 30 Aug 2006 18:56:11 +0200
User-Agent: KMail/1.9.3
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
References: <44F1F356.5030105@zytor.com> <44F3555F.6060306@zytor.com> <20060830194942.12cbf169@localhost>
In-Reply-To: <20060830194942.12cbf169@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301856.11125.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 18:49, Alon Bar-Lev wrote:
> 
> Extending the kernel parameters to a 2048 bytes for
> boot protocol >=2.02 of i386, ia64 and x86_64 architectures for
> linux-2.6.18-rc4-mm2.
> 
> Current implementation allows the kernel to receive up to
> 255 characters from the bootloader. In current environment,
> the command-line is used in order to specify many values,
> including suspend/resume, module arguments, splash, initramfs
> and more. 255 characters are not enough anymore.
> 
> EDD issue was fixed recently by H. Peter Anvin, please add this
> to mm so more problems may be found.

IA64 booting is completely different. I don't think it should 
be in this patch. At least you would need to check with the IA64
maintainer first.

And the other thing is that this will cost memory. Either make
it dependend on !CONFIG_SMALL or fix the boot code to save the 
command line into a kmalloc'ed buffer of the right size and __init 
the original one

-Andi
