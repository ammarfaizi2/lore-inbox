Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUBYCgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbUBYCgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:36:18 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:36040 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S262352AbUBYCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:36:16 -0500
Subject: Re: [oops] XFS? 2.6.3 build with gcc 3.3.3 running on Opteron
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1077653836.7783.55.camel@clubneon.priv.hereintown.net>
References: <1077653836.7783.55.camel@clubneon.priv.hereintown.net>
Content-Type: text/plain
Message-Id: <1077676574.9099.9.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 21:36:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 15:17, Chris Meadors wrote:
> Just got this oops, looks like it might be XFS related.  But I'm no good
> at decoding these things.
> 
> As the subject says this is a plain vanilla 2.6.3 kernel built with the
> just released gcc 3.3.3.  All file systems are XFS.

Just got another one.  I'll this time it went on for a couple tumbles. 
I'll just post the first oops.  I can get you any more info you need.

Some more details about the machine and kernel.  It is a dual Opteron,
SMP kernel, without preempt.  It was plenty stable compiling for hours
at a time.  But now with a real active load on it, it has given up twice
in 24 hours.

I'm going to try the current (2.6.3-1) X86-64 patchkit from Andi Kleen
to see if that helps any.

 

Bad page state at free_hot_cold_page
flags:0x10000000000014 mapping:0000000000000000 mapped:1 count:0
Backtrace:

Call Trace:<ffffffff8013e6fb>{bad_page+75} <ffffffff8013ee9f>{free_hot_cold_page+111}
       <ffffffff8013f530>{__pagevec_free+32} <ffffffff801449db>{release_pages+331}
       <ffffffff80154734>{free_pages_and_swap_cache+116} <ffffffff801489c7>{zap_pte_range+503}
       <ffffffff80148ae6>{zap_pmd_range+198} <ffffffff80148b50>{unmap_page_range+80}
       <ffffffff80148cb1>{unmap_vmas+305} <ffffffff8014d772>{exit_mmap+290}
       <ffffffff80123548>{mmput+88} <ffffffff801278cc>{do_exit+476}
       <ffffffff80127bdb>{do_group_exit+235} <ffffffff80130db0>{get_signal_to_deliver+1152}
       <ffffffff8010e8fd>{do_signal+125} <ffffffff80110b0f>{do_general_protection+159}
       <ffffffff8010f1e8>{retint_signal+62}
Trying to fix it up, but a reboot is needed


-- 
Chris

