Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286953AbSABLiR>; Wed, 2 Jan 2002 06:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286966AbSABLiF>; Wed, 2 Jan 2002 06:38:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37897 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286962AbSABLiB>; Wed, 2 Jan 2002 06:38:01 -0500
Subject: Re: [PATCH] C undefined behavior fix
To: aaronl@vitelus.com (Aaron Lehmann)
Date: Wed, 2 Jan 2002 11:48:11 +0000 (GMT)
Cc: velco@fadata.bg (Momchil Velikov), linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020102112821.GA13212@vitelus.com> from "Aaron Lehmann" at Jan 02, 2002 03:28:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LjsR-0003nw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is Linux not using this? It sounds very appropriate. The only
> things the manpage mentions that -fno-builtin would inhibit from being
> optimized are memcpy() and alloca(). memcpy() has its own assembly

There are others in newer gcc's, and on the whole gcc does a very good
job with them, so IMHO it is worth being nice to gcc to get the advantages.

> I only see it being used a bit in the S/390 code, where the gcc
> optimizations could quite possibly break something. I think
> -ffreestanding definately should be used by the kernel to prevent gcc
> from messing with its code in broken ways.

-ffreestanding for the compiler versions that support it can be added to
arch specific flags anyway
