Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbTEaBCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 21:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTEaBCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 21:02:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:5388 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264096AbTEaBCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 21:02:02 -0400
Date: Fri, 30 May 2003 18:15:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: jjs <jjs@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make 2.5.70-mm2 dies with error
Message-Id: <20030530181526.02b58783.akpm@digeo.com>
In-Reply-To: <3ED64AE7.10509@tmsusa.com>
References: <3ED64AE7.10509@tmsusa.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2003 01:15:22.0523 (UTC) FILETIME=[1BC3FEB0:01C32712]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjs <jjs@tmsusa.com> wrote:
>
> This may be of interest:
> 
> NB 2.5.70-mm1 built and ran OK here -
> 
> mm/built-in.o(.text+0x5095): In function `__map_pages':
> : undefined reference to `__flush_tlb_all'
> make: *** [.tmp_vmlinux1] Error 1
> 

Drop a #include <asm/tlbflush.h> into mm/page_alloc.c

