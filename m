Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVJJPSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVJJPSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVJJPSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:18:51 -0400
Received: from [218.22.21.1] ([218.22.21.1]:59047 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750856AbVJJPSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:18:50 -0400
Date: Mon, 10 Oct 2005 23:21:43 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] use radix_tree for non-resident page tracking
Message-ID: <20051010152141.GA6714@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Yingchao Zhou <yc_zhou@ncic.ac.cn>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051010134345.C9E7CFB046@gatekeeper.ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010134345.C9E7CFB046@gatekeeper.ncic.ac.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 09:37:47PM +0800, Yingchao Zhou wrote:
> The paper "The Performance Impact of Kernel Prefetching On Buffer 
> Cache Replacement Algorithms" appeared in SIGMETRICS05 gives some 
> interesting relative results of replacement algorithm when taking 
Thanks for the information, it should help my work on read-ahead.
I noticed similar problem when testing read-ahead behavior for fs-on-loop.
The basic conclusion is read-ahead in the block device level can
complement file level read-ahead, for the latter does not do inter-file
read-ahead.  But it has to be limited/conservative, because the risk of
cache miss is much higher.
> into account of prefetching. How about the situation in CLOCK-Pro
> project?
Sorry, I'm new to CLOCK-Pro, too...

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
