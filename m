Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUH1GT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUH1GT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUH1GT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:19:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:16081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268186AbUH1GTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:19:08 -0400
Date: Fri, 27 Aug 2004 23:17:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-Id: <20040827231713.212245c5.akpm@osdl.org>
In-Reply-To: <20040828053112.GB2793@holomorphy.com>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<20040828052627.GA2793@holomorphy.com>
	<20040828053112.GB2793@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>  void fastcall unlock_page(struct page *page)
>   {
>  +	unsigned long *word = (unsigned long *)&page->flags;

This will break if a little-endian 64-bit architecture elects to use a
32-bit page_flags_t.

