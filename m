Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTD3UqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTD3UqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:46:00 -0400
Received: from [12.47.58.20] ([12.47.58.20]:12884 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262386AbTD3Up7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:45:59 -0400
Date: Wed, 30 Apr 2003 13:55:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: dphillips@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030430135512.6519eb53.akpm@digeo.com>
In-Reply-To: <200304300446.24330.dphillips@sistina.com>
References: <200304300446.24330.dphillips@sistina.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 20:58:13.0711 (UTC) FILETIME=[37159DF0:01C30F5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <dphillips@sistina.com> wrote:
>
> +static inline unsigned fls8(unsigned n)
> +{
> +	return n & 0xf0?
> +	    n & 0xc0? (n >> 7) + 7: (n >> 5) + 5:
> +	    n & 0x0c? (n >> 3) + 3: n - ((n + 1) >> 2);
> +}

	return fls_table[n];


That'll be faster in benchmarks, possibly slower in real world.  As usual.

