Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbSJGNaC>; Mon, 7 Oct 2002 09:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbSJGNaC>; Mon, 7 Oct 2002 09:30:02 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:4847 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263036AbSJGN34>; Mon, 7 Oct 2002 09:29:56 -0400
Subject: Re: PATCH: 2.5.40 sane minimum proc count
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021007142700.I18545@parcelfarce.linux.theplanet.co.uk>
References: <20021007142700.I18545@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 14:44:43 +0100
Message-Id: <1033998283.25063.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 14:27, Matthew Wilcox wrote:
> why not simply:
> 
> 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
> 
> +	/* we need to allow at least 20 threads to boot a system */
> +	if (max_threads < 20)
> +		max_threads = 20;
> +
> 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
> 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
> 
> i think we're going to see more kernel threads with 2.5 than we did with 2.4;
> let's be safer.

Much better, will switch

