Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUIDVEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUIDVEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUIDVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:04:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:32986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266170AbUIDVEF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:04:05 -0400
Date: Sat, 4 Sep 2004 14:02:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz =?ISO-8859-1?B?SmFfX2tpZXdpY3o=?= <gryzman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: current -mm3 compilation problem
Message-Id: <20040904140203.24947e03.akpm@osdl.org>
In-Reply-To: <2f4958ff04090413314fe67f3f@mail.gmail.com>
References: <2f4958ff04090413314fe67f3f@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Ja__kiewicz <gryzman@gmail.com> wrote:
>
> fs/built-in.o(.text+0xa811c): In function `gzip1_alloc':
>  : undefined reference to `in_softirq'
>  fs/built-in.o(.text+0xa81d1): In function `gzip1_alloc':
>  : undefined reference to `in_softirq'

Put a

	#include <linux/hardirq.h>

into fs/reiser4/plugin/compress/compress.c
