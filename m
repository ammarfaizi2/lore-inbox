Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTFCXB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTFCXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:01:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15047 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261807AbTFCXB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:01:28 -0400
Date: Tue, 3 Jun 2003 16:11:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat-fs printk arg. fix
Message-Id: <20030603161134.0d1755df.akpm@digeo.com>
In-Reply-To: <20030603160200.04991141.rddunlap@osdl.org>
References: <20030603160200.04991141.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 23:14:56.0119 (UTC) FILETIME=[F2254070:01C32A25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
>  		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
> -		       phys);
> +		       (u64)phys);

The printk control string says, precisely, "unsigned long long".  So that
is what we should be casting the argument to.

I have made that change, thanks.
