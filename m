Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCRUV1>; Mon, 18 Mar 2002 15:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292792AbSCRUVU>; Mon, 18 Mar 2002 15:21:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3719 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292780AbSCRUU6>;
	Mon, 18 Mar 2002 15:20:58 -0500
Date: Mon, 18 Mar 2002 12:22:16 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Message-ID: <15780000.1016482936@w-hlinder.des>
In-Reply-To: <3C964AA3.4B85EA0B@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, March 18, 2002 12:14:27 -0800 Andrew Morton <akpm@zip.com.au> wrote:

> One other possible explanation is to do with radix-tree pagecache.
> It has to allocate memory to add nodes to the tree.  When these
> allocations start failing due to out-of-memory, the VM will keep
> on calling swap_out() a trillion times without noticing that it
> didn't work out.  But if this happened, yo would have seen a huge
> number of "0-order allocation failed" messages.

	Yes, I did see a huge number of those messages. It also died
	on 2.5.6 clean though. I chalked it up to 2.5 instability.
	Will test again when things calm down. Any chance you will
	backport to 2.4?
	
	Glad to help.

	Hanna



