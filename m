Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFBJQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTFBJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:16:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:61356 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262063AbTFBJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:16:08 -0400
Date: Mon, 2 Jun 2003 02:29:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm3
Message-Id: <20030602022939.17855838.akpm@digeo.com>
In-Reply-To: <200306021017.15633.alistair@devzero.co.uk>
References: <20030531013716.07d90773.akpm@digeo.com>
	<200306021017.15633.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2003 09:29:33.0939 (UTC) FILETIME=[7A368430:01C328E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair J Strachan <alistair@devzero.co.uk> wrote:
>
> Bad page state at free_hot_cold_page
>  flags:0x01010000 mapping:00000000 mapped:1 count:0
>  Backtrace:
>  Call Trace:
>   [bad_page+93/144] bad_page+0x5d/0x90
>   [free_hot_cold_page+112/256] free_hot_cold_page+0x70/0x100
>   [zap_pte_range+385/448] zap_pte_range+0x181/0x1c0
>   [do_wp_page+437/848] do_wp_page+0x1b5/0x350
>   [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
>   [unmap_page_range+75/128] unmap_page_range+0x4b/0x80
>   [unmap_vmas+254/544] unmap_vmas+0xfe/0x220
>   [exit_mmap+109/384] exit_mmap+0x6d/0x180
>   [mmput+65/176] mmput+0x41/0xb0
>   [do_exit+243/832] do_exit+0xf3/0x340

eww, that's a PageDirect page.  Never seen that before - it's
bad.

Is the box SMP?
