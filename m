Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUELA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUELA2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUELAYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:24:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:43710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265074AbUELAUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:20:54 -0400
Date: Tue, 11 May 2004 17:23:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: edwardsg@sgi.com (Greg Edwards)
Cc: linux-kernel@vger.kernel.org, thockin@sun.com
Subject: Re: [PATCH] calculate NGROUPS_PER_BLOCK from PAGE_SIZE
Message-Id: <20040511172325.127c1309.akpm@osdl.org>
In-Reply-To: <20040511174944.GA26708@sgi.com>
References: <20040511174944.GA26708@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

edwardsg@sgi.com (Greg Edwards) wrote:
>
> On ia64, EXEC_PAGESIZE (max page size) is 65536, but the default page
> size is 16k.  This results in NGROUPS_PER_BLOCK in include/linux/sched.h
> being calculated incorrectly when the page size is anything other than
> 64k.  For example, on a 16k page size kernel, a setgroups() call with a
> gidsetsize of 65536 will end up walking over memory since only 1/4 of
> the needed pages were allocated for the blocks[] array in the group_info
> struct.
> 
> Patch below calculates NGROUPS_PER_BLOCK from PAGE_SIZE instead.

yep, thanks.
