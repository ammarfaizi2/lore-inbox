Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUHRUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUHRUxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHRUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:53:44 -0400
Received: from holomorphy.com ([207.189.100.168]:22713 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267646AbUHRUxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:53:42 -0400
Date: Wed, 18 Aug 2004 13:53:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818205338.GF11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, lkml <linux-kernel@vger.kernel.org>
References: <20040818133348.7e319e0e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818133348.7e319e0e.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 01:33:48PM -0700, Paul Jackson wrote:
> and the following files using 6 args:
>         arch/sparc/mm/generic.c
>         drivers/sbus/char/vfc_dev.c
>         include/asm-sparc/pgtable.h
>         include/asm-sparc64/pgtable.h
> I'm noticing this trying to build 2.6.8.1-mm1 sparc64, using crosstool
> and 'make defconfig'.   It errors out with:
>  $ make sound/core/pcm_native.o
>  CC [M]  sound/core/pcm_native.o
>  sound/core/pcm_native.c: In function `snd_pcm_mmap_data':
>  sound/core/pcm_native.c:3088: error: too few arguments to function `io_remap_page_range'
> My dimm recollection is that this error has been here a while, but that
> I've just been commenting CONFIG_SOUND out, since I really didn't care
> about either sound nor about sparc64 (only that I wasn't contributing
> further grief to sparc64 with my cpumask and cpuset stuff).
> Does anyone know the story behind this odd inconsistency?
> Better yet, is anyone signed up to resolve this?  No, I'm not
> volunteering ;).

Once it's decided how many it really takes, I'll fix up sparc32 as-needed.

-- wli
