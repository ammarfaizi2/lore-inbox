Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSG1UGS>; Sun, 28 Jul 2002 16:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSG1UGS>; Sun, 28 Jul 2002 16:06:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40169 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317191AbSG1UGR>;
	Sun, 28 Jul 2002 16:06:17 -0400
Date: Sun, 28 Jul 2002 22:08:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for Linux,
  2.5.28
In-Reply-To: <3D443B8C.7C2028B0@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207282207450.32536-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Oleg Nesterov wrote:

> +	 * Load the per-thread Thread-Local Storage descriptor.
> +	 *
> +	 * NOTE: it's faster to do the two stores unconditionally
> +	 * than to branch away.
> +	 */
> +	load_TLS_desc(next, cpu);
> +
> +	/*
>  	 * Save away %fs and %gs. No need to save %es and %ds, as

actually, shouldnt this be done after saving the current %fs and %gs, and
before loading the next %fs and %gs?

	Ingo

