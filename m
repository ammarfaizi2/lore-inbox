Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbTAFUso>; Mon, 6 Jan 2003 15:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTAFUso>; Mon, 6 Jan 2003 15:48:44 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:42763 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S267130AbTAFUsn>;
	Mon, 6 Jan 2003 15:48:43 -0500
Date: Mon, 6 Jan 2003 15:57:19 -0500
Message-Id: <200301062057.h06KvJA03060@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix starfire compiler warning on PAE
In-Reply-To: <99960000.1041743313@titus>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jan 2003 21:08:33 -0800, Martin J. Bligh <mbligh@aracnet.com> wrote:

> diff -urpN -X /home/fletch/.diff.exclude 
> 12-boot_error/drivers/net/starfire.c 
> 19-fix_starfire_warning/drivers/net/starfire.c
> --- 12-boot_error/drivers/net/starfire.c        Fri Dec 13 23:17:59 2002
> +++ 19-fix_starfire_warning/drivers/net/starfire.c      Thu Jan  2 22:18:18 2003

Fix the compiler warning, yes; fix the driver for 64-bit dma_addr_t, no.
It may work with PAE, by chance, if all addresses returned by pci_map_single
and friends are < (1 << 33), but not otherwise.

Jeff already has an updated starfire driver in his queue, complete with
full 64-bit support.

[the cc: to the maintainer is always appreciated...]

Ion
[starfire driver maintainer]

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
