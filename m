Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUHAVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUHAVFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUHAVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 17:05:38 -0400
Received: from ozlabs.org ([203.10.76.45]:25815 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266173AbUHAVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 17:05:35 -0400
Date: Mon, 2 Aug 2004 07:00:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use for_each_cpu
Message-ID: <20040801210025.GK30253@krispykreme>
References: <20040801060144.GI30253@krispykreme> <20040731230859.138ba584.akpm@osdl.org> <20040801072711.GJ30253@krispykreme> <20040801004708.6fa9f6f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801004708.6fa9f6f8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> yup ;) It's only six lines, and it follows the same pattern as is used in,
> say, page_alloc_cpu_notify().  Doing the same thing the same way in
> multiple places is to be preferred, yes?

If the data structure contains allocated memory, like per cpu pages I
agree. But for percpu stuff that is straight stats (eg nr_running), I
thought the aim was to just total all all possible cpus. bh_accounting
is another one that falls into this group.

Anton
