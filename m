Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVK1AgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVK1AgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVK1AgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:36:12 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:59314 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751194AbVK1AgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:36:12 -0500
Date: Mon, 28 Nov 2005 08:52:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: ck@vds.kolivas.org
Cc: Con Kolivas <kernel@kolivas.org>, Frederik <freggy@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] 2.6.15-rc2-ck2 with adaptive readahead: processes stuck in D state
Message-ID: <20051128005208.GB4022@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>, ck@vds.kolivas.org,
	Con Kolivas <kernel@kolivas.org>, Frederik <freggy@gmail.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511281014.13780.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it's this patch that solved the problem:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=551c81e2d32c5867fb592091365d8c37e1509dce
[XFS] Resolve the xlog_grant_log_space hang, revert inline to macro.

Cheers,
Wu

----- Forwarded message from Nathan Scott <nathans@sgi.com> -----

Subject: Re: processes stuck in D state
From: Nathan Scott <nathans@sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-xfs@oss.sgi.com
User-Agent: Mutt/1.2.5i
Date: Mon, 28 Nov 2005 11:23:45 +1100

On Mon, Nov 28, 2005 at 08:36:25AM +0800, Wu Fengguang wrote:
> Hello,
> 
> In the kernel 2.6.15-rc2-ck2 with adaptive readahead patch, some processes are
> stuck in D state. Since the last functions of the two D process happened to be
> the same set of XFS functions, I resend the bug report here. The original report
> can be found in the -ck kernel mailing list:
> http://bhhdoa.org.au/pipermail/ck/2005-November/004839.html

This is now fixed in Linus' git tree.

cheers.

-- 
Nathan

----- End forwarded message -----
