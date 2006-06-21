Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWFUVzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWFUVzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFUVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:55:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:18152 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030190AbWFUVzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:55:43 -0400
Date: Wed, 21 Jun 2006 17:55:39 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML/x86_64 broke on debian etch
Message-ID: <20060621215539.GA7270@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0606211345030.21866@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211345030.21866@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:47:45PM -0700, Christoph Lameter wrote:
> Tried to use UML to do the page migration testing for x86_64 but ....

>   CC      arch/um/kernel/asm-offsets.s
> In file included from include/asm/timex.h:14,
>                  from include/linux/timex.h:61,
>                  from include/linux/sched.h:11,
>                  from arch/um/include/sysdep/kernel-offsets.h:3,
>                  from arch/um/kernel/asm-offsets.c:1:
> include/asm/processor.h:74: error: 'CONFIG_X86_L1_CACHE_SHIFT' undeclared 
> here (not in a function)
> include/asm/processor.h:74: error: requested alignment is not a constant
> include/asm/processor.h:229: error: requested alignment is not a constant

Did you start with a defconfig?

This is what the corresponding part of my x86_64 build looks like
(2.6.17.1):

  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/bin2c
  CC      arch/um/kernel/asm-offsets.s
  GEN     include/asm-um/asm-offsets.h
  CC      init/main.o

				Jeff
