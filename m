Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbRLFIIq>; Thu, 6 Dec 2001 03:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285046AbRLFII1>; Thu, 6 Dec 2001 03:08:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:12182 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S285045AbRLFIIX>;
	Thu, 6 Dec 2001 03:08:23 -0500
Date: Thu, 06 Dec 2001 00:07:04 -0800 (PST)
Message-Id: <20011206.000704.98557874.davem@redhat.com>
To: kaos@ocs.com.au
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <12352.1007623285@kao2.melbourne.sgi.com>
In-Reply-To: <E16BkER-0006J0-00@wagner>
	<12352.1007623285@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Thu, 06 Dec 2001 18:21:25 +1100
   
   Did you look at PERCPU_ADDR in ia64?  Much (all?) of the per cpu data
   is in struct cpuinfo_ia64 which is at the same virtual address on all
   cpus but with different physical addresses on each cpu.  Let the mmu do
   the work.

What an absolutely aweful waste of a TLB entry.
