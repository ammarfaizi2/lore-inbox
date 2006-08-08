Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWHHOjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWHHOjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWHHOjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:39:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59093 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964928AbWHHOjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:39:40 -0400
Date: Tue, 8 Aug 2006 17:39:37 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
Message-ID: <20060808143937.GA3953@rhun.haifa.ibm.com>
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608081432.k78EWprf007511@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 07:32:51AM -0700, akpm@osdl.org wrote:
> 
> The patch titled
> 
>      sys_getppid() oopses on debug kernel
> 
> has been added to the -mm tree.  Its filename is
> 
>      sys_getppid-oopses-on-debug-kernel.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: sys_getppid() oopses on debug kernel
> From: Kirill Korotaev <dev@sw.ru>
> 
> sys_getppid() optimization can access a freed memory.  On kernels with
> DEBUG_SLAB turned ON, this results in Oops.
> 
> Signed-off-by: Kirill Korotaev <dev@openvz.org>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

I'm probably missing something, but is it really valid to access freed
kernel memory even if CONFIG_DEBUG_SLAB is off - as this patch does?

Cheers,
Muli
