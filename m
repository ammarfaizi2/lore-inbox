Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315977AbSEGVYk>; Tue, 7 May 2002 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315978AbSEGVYj>; Tue, 7 May 2002 17:24:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13217 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315977AbSEGVYh>;
	Tue, 7 May 2002 17:24:37 -0400
Date: Tue, 07 May 2002 14:12:55 -0700 (PDT)
Message-Id: <20020507.141255.50261362.davem@redhat.com>
To: thunder@ngforever.de
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205071441140.4189-100000@hawkeye.luckynet.adm>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@ngforever.de>
   Date: Tue, 7 May 2002 14:43:08 -0600 (MDT)

   +#define pfn_to_page(pfn)		(mem_map + (pfn))
   +#define pte_pfn(x)			(pte_val(x) >> PAGE_SHIFT)

Wrong wrong wrong, you aren't factoring in 'phys_base'
This is required on sparc64.
