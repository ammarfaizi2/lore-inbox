Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279596AbRJ2XOa>; Mon, 29 Oct 2001 18:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279598AbRJ2XOU>; Mon, 29 Oct 2001 18:14:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46483 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279596AbRJ2XOF>;
	Mon, 29 Oct 2001 18:14:05 -0500
Date: Mon, 29 Oct 2001 15:14:22 -0800 (PST)
Message-Id: <20011029.151422.102554141.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011029180837.F25434@redhat.com>
In-Reply-To: <20011029180837.F25434@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 29 Oct 2001 18:08:37 -0500

   is completely bogus.  Without the tlb flush, the system may never update 
   the accessed bit on a page that is heavily being used.

It's intentional Ben, think about the high cost of the SMP invalidate
when kswapd is just scanning page tables.

Franks a lot,
David S. Miller
davem@redhat.com
