Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268075AbUH1UY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268075AbUH1UY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUH1UWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:22:41 -0400
Received: from holomorphy.com ([207.189.100.168]:7081 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266512AbUH1UVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:21:21 -0400
Date: Sat, 28 Aug 2004 13:21:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: [2/5] consolidate bit waiting code patterns
Message-ID: <20040828202120.GX5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828200841.GT5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:08:41PM -0700, William Lee Irwin III wrote:
> Eliminate specialized page and bh waitqueue hashing structures in favor
> of a standardized structure, using wake_up_bit() to wake waiters using
> the standardized wait_bit_key structure.
> 
> Index: wait-2.6.9-rc1-mm1/fs/buffer.c
> ===================================================================
> --- wait-2.6.9-rc1-mm1.orig/fs/buffer.c	2004-08-28 09:43:30.305969176 -0700
> +++ wait-2.6.9-rc1-mm1/fs/buffer.c	2004-08-28 09:47:21.232862952 -0700
> @@ -43,26 +43,6 @@
>  
>  #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)

Sorry, the Subject: line should have been titled "standardize bit
waiting data type".


-- wli
