Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUGZH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUGZH0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUGZH0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:26:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:53432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264966AbUGZH0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:26:49 -0400
Date: Mon, 26 Jul 2004 00:25:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Rutt <rutt.4+news@osu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
Message-Id: <20040726002524.2ade65c3.akpm@osdl.org>
In-Reply-To: <87vfgeuyf5.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Rutt <rutt.4+news@osu.edu> wrote:
>
>  How can I purge all of the kernel's filesystem caches, so I can trust
>  that my I/O (read) requests I'm trying to benchmark bypass the kernel
>  filesystem cache?

Either delete the benchmark test files or, in 2.6, use
fsync+posix_fadvise(POSIX_FADV_DONTNEED);
