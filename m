Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUFZFCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUFZFCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 01:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266551AbUFZFCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 01:02:54 -0400
Received: from palrel12.hp.com ([156.153.255.237]:64696 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266365AbUFZFCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 01:02:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16605.890.602430.309399@napali.hpl.hp.com>
Date: Fri, 25 Jun 2004 22:02:50 -0700
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
In-Reply-To: <20040623183535.GV827@hygelac>
References: <20040623183535.GV827@hygelac>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence,

>>>>> On Wed, 23 Jun 2004 13:35:35 -0500, Terence Ripperda <tripperda@nvidia.com> said:

  Terence> based on each architecture's paging_init routines, the
  Terence> zones look like this:

  Terence>                 x86:         ia64:      x86_64:
  Terence> ZONE_DMA:       < 16M        < ~4G      < 16M
  Terence> ZONE_NORMAL:    16M - ~1G    > ~4G      > 16M
  Terence> ZONE_HIMEM:     1G+

Not that it matters here, but for correctness let me note that the
ia64 column is correct only for machines which don't have an I/O MMU.
With I/O MMU, ZONE_DMA will have the same coverage as ZONE_NORMAL with
a recent enough kernel (older kernels had a bug which limited ZONE_DMA
to < 4GB, but that was unintentional).

	--david
