Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319351AbSHVOZg>; Thu, 22 Aug 2002 10:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319353AbSHVOZg>; Thu, 22 Aug 2002 10:25:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9981 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S319351AbSHVOZf>; Thu, 22 Aug 2002 10:25:35 -0400
Date: Thu, 22 Aug 2002 15:30:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nir Soffer <nirs@exanet.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bourne <jbourne@mtroyal.ab.ca>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Hyperthreading
In-Reply-To: <4913AB320D31DC4798D6FEF5F557351F6B9994@hawk.exanet-il.co.il>
Message-ID: <Pine.LNX.4.44.0208221506300.1253-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Nir Soffer wrote:
> 
> Grepping for MPENTIUM4 in the tree only shows up that it causes the
> kernel to be compiled with -march=i686, much like M686 and  MPENTIUMIII.
> Are there more subtle ways it affects the kernel that I missed? (in the
> 2.4.x tree)

arch/i386/config.in is where the processor characteristics CONFIG_X86_...
are derived from processor type.  There's only one difference between
the CONFIG_MPENTIUMIII configs and the CONFIG_MPENTIUM4 configs (in
2.4.18 or 2.4.19 or 2.4.20-pre4): CONFIG_X86_L1_CACHE_SHIFT 5 or 7.

Alan, that reminds me: 2.4.20-ac sets CONFIG_X86_L1_CACHE_SHIFT 7
when CONFIG_MPENTIUMIII: looks wrong, but perhaps there's a reason?

Hugh

