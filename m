Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSBMTMR>; Wed, 13 Feb 2002 14:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288677AbSBMTMF>; Wed, 13 Feb 2002 14:12:05 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:44295 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S288685AbSBMTMB>; Wed, 13 Feb 2002 14:12:01 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [patch] printk and dma_addr_t
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D2172BC@nasdaq.ms.ensim.com>
Message-Id: <E16b4or-0004dg-00@pmenage-dt.ensim.com>
Date: Wed, 13 Feb 2002 11:11:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D2172BC@nasdaq.ms.ensim.com>,
you write:
>+#ifdef __KERNEL__
>+char *form_dma_addr_t(char *buf, dma_addr_t a);
>+#endif
>+

How about an typedef for da_buf_t (or similar) so that drivers don't
have to worry about the size of the buffer? And that would also let you
reduce the stack footprint on systems where dma_addr_t is only 32 bits,
although that's probably not going to produce a noticeable benefit.

Paul
