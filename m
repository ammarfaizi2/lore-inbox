Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282964AbRLCIvm>; Mon, 3 Dec 2001 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284407AbRLCIuG>; Mon, 3 Dec 2001 03:50:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62615 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284473AbRLCAFr>;
	Sun, 2 Dec 2001 19:05:47 -0500
Date: Sun, 02 Dec 2001 16:05:38 -0800 (PST)
Message-Id: <20011202.160538.27781249.davem@redhat.com>
To: anton@samba.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5: PCI scatter gather list change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011202153553.B5130@krispykreme>
In-Reply-To: <20011202153553.B5130@krispykreme>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sun, 2 Dec 2001 15:35:53 +1100
   
   I dont care too much either way, but if this change is here to stay I'll
   let the non intel maintainers know so they can fix up their pci dma
   code.

Ummm, platforms need to support this format even in 2.4.x
If PAGE is not NULL, "address" applies, else the PAGE+OFFSET
pair applies.  We'll kill "address" very soon in 2.5.x, but it
has to stay around for compatibility in 2.4.x

Look at sparc64 and x86 in 2.4.x, they expect and handle it
correctly already.  IA-64 fixed up their stuff recently too.

