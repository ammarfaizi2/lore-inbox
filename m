Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWHaXIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHaXIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHaXIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:08:43 -0400
Received: from averell.tiscali.it ([213.205.33.55]:31903 "EHLO
	averell.tiscali.it") by vger.kernel.org with ESMTP id S932107AbWHaXIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:08:42 -0400
Date: Fri, 1 Sep 2006 01:08:38 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Oops while reading netdev stats from /proc/
Message-ID: <20060831230838.GA15089@pp>
References: <20060831200048.GA13051@pp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831200048.GA13051@pp>
User-Agent: Mutt/1.3.28i
From: Paolo <oopla@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 10:00:49PM +0200, oopla wrote:
> ksymoops 2.4.11 on i686 2.4.33.2-i+isdn-k7.  Options used
...
> Aug 28 14:10:29 estero1 kernel: Unable to handle kernel paging request at virtual address 022d9222
> Aug 28 14:10:29 estero1 kernel: c01fb0c7
> Aug 28 14:10:29 estero1 kernel: *pde = 00000000
> Aug 28 14:10:29 estero1 kernel: Oops: 0002
> Aug 28 14:10:29 estero1 kernel: CPU:    0
> Aug 28 14:10:29 estero1 kernel: EIP:    0010:[sprintf_stats+103/176]    Not tainted
...


please keep it aside for a while, till I check the pc - just seen another
oops in the logs with latest 2.4.x kernel:


ksymoops 2.4.11 on i686 2.4.33.2-i+isdn-k7.  Options used
...
Aug 31 15:35:16 estero1 kernel: Unable to handle kernel paging request at virtua
l address 69772f91
Aug 31 15:35:16 estero1 kernel: c0117c71
Aug 31 15:35:16 estero1 kernel: *pde = 00000000
Aug 31 15:35:16 estero1 kernel: Oops: 0002
Aug 31 15:35:16 estero1 kernel: CPU:    0
Aug 31 15:35:16 estero1 kernel: EIP:    0010:[copy_mm+657/704]    Not tainted
Aug 31 15:35:16 estero1 kernel: EFLAGS: 00010202
Aug 31 15:35:16 estero1 kernel: eax: 00004111   ebx: daa20000   ecx: f7e34440   
edx: f748a000
...


and at this point I suspect RAM problems.

thanks

8-- paolo

