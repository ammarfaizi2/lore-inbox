Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVJFKmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVJFKmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVJFKmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:42:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:48301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750805AbVJFKmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:42:19 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Date: Thu, 6 Oct 2005 12:42:25 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
References: <20051005161706.B30098@unix-os.sc.intel.com>
In-Reply-To: <20051005161706.B30098@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061242.26563.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 01:17, Siddha, Suresh B wrote:

> +
> +#ifdef CONFIG_X86_HT
> +#ifndef CONFIG_X86_64
> +#include <mach_apic.h>
> +#else
> +#include <asm/mach_apic.h>
> +#endif

Having such ifdefs is a clear cue that the code shouldn't be shared
between architectures.

-Andi
