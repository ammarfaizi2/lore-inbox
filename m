Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbVKJC7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbVKJC7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVKJC7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:59:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751678AbVKJC7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:59:19 -0500
Date: Wed, 9 Nov 2005 18:58:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051109185859.03a8d2ac.akpm@osdl.org>
In-Reply-To: <20051109185645.39329151.akpm@osdl.org>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
	<20051109185645.39329151.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Well plan B is to kill spinlock_t.break_lock.

And plan C is to use a bit_spinlock() against page->flags.
