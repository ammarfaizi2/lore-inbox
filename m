Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHFQqC>; Tue, 6 Aug 2002 12:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSHFQqC>; Tue, 6 Aug 2002 12:46:02 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59665 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313563AbSHFQqB>; Tue, 6 Aug 2002 12:46:01 -0400
Date: Tue, 6 Aug 2002 12:58:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Patricia Gaughen <gone@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of mem_init() for 2.4.20pre1
In-Reply-To: <200208060317.g763Hx825104@w-gaughen.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0208061258200.7534-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Aug 2002, Patricia Gaughen wrote:

>
> Please consider this patch for inclusion into the 2.4.20pre tree.
> It was accepted into the 2.4.19pre6aa1, with slight modifications
> by Andrea that I have incorporated those changes into my patch.
> This patch, along with the modularization of setup_arch, and the
> {node,zone}_start_paddr to {node,zone}_start_pfn change, are the
> patches that my i386 discontigmem patch depends on.
>
> This patch restructures mem_init() for i386 to make it easier to
> include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been
> working on.  It also makes mem_init() easier to read.
>
> This patch does not depend on the other patches I'm submitting today, but
> my discontigmem patch does depend on this one.
>
> I've tested this patch on the following configurations: UP, SMP, SMP PAE,
> multiquad, multiquad PAE, multiquad DISCONTIGMEM, multiquad DISCONTIGMEM PAE.
>
> Any and all feedback regarding this patch is greatly appreciated.

It looks ok but what about surrounding init_one_highpage with
CONFIG_HIGHMEM?

