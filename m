Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277591AbRJHXGI>; Mon, 8 Oct 2001 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277592AbRJHXF5>; Mon, 8 Oct 2001 19:05:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277591AbRJHXFm>;
	Mon, 8 Oct 2001 19:05:42 -0400
Date: Mon, 08 Oct 2001 16:05:28 -0700 (PDT)
Message-Id: <20011008.160528.85686937.davem@redhat.com>
To: pmanolov@Lnxw.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC22EA6.696604E7@lnxw.com>
In-Reply-To: <3BC0E9FD.4F3921C6@mvista.com>
	<3BC2158E.BE52400D@welho.com>
	<3BC22EA6.696604E7@lnxw.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Petko Manolov <pmanolov@Lnxw.COM>
   Date: Mon, 08 Oct 2001 15:54:30 -0700
   
   Any ideas how to make lowest 4MB allocatable throu
   kmalloc(size, GFP_DMA) without breaking the kernel?

Setup ZONE_DMA correctly at boot time.

See the code around the free_area_init() call in
arch/i386/mm/init.c for an example of how to do this.
Intel does it for the low 16MB, you would just do it
for the low 4MB.

Franks a lot,
David S. Miller
davem@redhat.com
