Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTEFO36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTEFO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:29:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32478 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263780AbTEFO34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:29:56 -0400
Date: Tue, 06 May 2003 07:41:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>
cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
Message-ID: <7530000.1052232109@[10.10.2.4]>
In-Reply-To: <20030506082948.B371D2C003@lists.samba.org>
References: <20030506082948.B371D2C003@lists.samba.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, May 06, 2003 18:28:24 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:

> +	pool_size = max(((long long)num_physpages << PAGE_SHIFT) / 16384,
> +			(long long)pool_size);

I like the idea of scaling it with the machine, but can you scale this off 
lowmem instead? Something like max_low_pfn or similar.

Thanks,

M.


