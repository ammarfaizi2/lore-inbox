Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136521AbREDVkX>; Fri, 4 May 2001 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136523AbREDVkD>; Fri, 4 May 2001 17:40:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57103 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136521AbREDVj7>; Fri, 4 May 2001 17:39:59 -0400
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
To: manfred@colorfullife.com (Manfred Spraul)
Date: Fri, 4 May 2001 22:43:32 +0100 (BST)
Cc: bergsoft@home.com, linux-kernel@vger.kernel.org
In-Reply-To: <3AF2FF93.44A2C49@colorfullife.com> from "Manfred Spraul" at May 04, 2001 09:14:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vnMM-00084d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> prefetch 320(%0) can fetch memory behind the end of the source page.
> Perhaps it accesses memory in the ISA hole, or beyond the end of memory?
> Could you post the e820 map from dmesg?
> 
> It's possible to build manually a memory map.
> Could you build one with wide margins from "dangerous" areas? (untested:
> mem=exactmap mem=620k@0 mem=<your mem in MB-2>M@1M)
> 
> Then boot with prefetch enabled.

That might not be the actual bug but for rev 1 Athlon it is a real bug. The
first step athlons have an unfortunate problem in that will prefetch
memory marked uncachable and corrupt their caches with it.

Arjan - care to unroll the tail 320 bytes of copying from the main loop ?

