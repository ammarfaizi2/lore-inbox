Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVG1ORO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVG1ORO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVG1ORI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:17:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42634 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261468AbVG1ORA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:17:00 -0400
Date: Thu, 28 Jul 2005 15:16:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] compat_sys_read/write
Message-ID: <20050728141653.GA22173@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 11:43:41PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Someone mentioned the mess in evdev.c that is caused by the fact that the
> structures that are passed to/from user mode via read/write require
> conversion when this API is used from 32 bit tasks on 64 bit kernels. 
> Some "discussion" followed during which I suggested an idea originally
> from Matthew Wilcox of an arch-specific is_compat_task() function so that
> these places could be identified.  However it was considered better to
> instead implement compat_sys_read/write.

This looks totally horrible, especially as we'd need readv/writev and
pread/pwrite aswell.  I don't think anyone but Andi actually liked this
approach when discussed earlier.

