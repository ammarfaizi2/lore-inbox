Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJ1Qnc>; Mon, 28 Oct 2002 11:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSJ1Qnc>; Mon, 28 Oct 2002 11:43:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47312 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261360AbSJ1Qnb>; Mon, 28 Oct 2002 11:43:31 -0500
Subject: Re: [PATCH] shmem missing cache flush
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, rmk@arm.linux.org.uk,
       hugh@veritas.com, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
References: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk>
	<20021028.061059.38206858.davem@redhat.com>
	<20021028143226.N27461@parcelfarce.linux.theplanet.co.uk>
	<20021028.062608.78045801.davem@redhat.com> 
	<20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 17:08:17 +0000
Message-Id: <1035824897.1945.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 16:36, Matthew Wilcox wrote:
> fs/binfmt_aout.c:357:           flush_icache_range(text_addr, text_addr+ex.a_text+ex.a_data);
> fs/binfmt_aout.c:381:                   flush_icache_range((unsigned long) N_TXTADDR(ex),
> fs/binfmt_aout.c:479:           flush_icache_range((unsigned long) start_addr,
> fs/binfmt_elf.c:422:    flush_icache_range((unsigned long)addr,
> 
> the kernel doesn't execute the code ranges here, userspace does.  Which
> means that the only place in the entire kernel which does need to call

Suppose those addresses are already in the userspace icache from a
different exec ?

