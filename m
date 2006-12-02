Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162871AbWLBJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162871AbWLBJnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162873AbWLBJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 04:43:17 -0500
Received: from mail.parknet.jp ([210.171.160.80]:36364 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1162871AbWLBJnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 04:43:15 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [new patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072247.GC18004@wotan.suse.de>
	<20061130113241.GC12579@wotan.suse.de>
	<87r6vkzinv.fsf@duaron.myhome.or.jp>
	<20061201020910.GC455@wotan.suse.de>
	<87mz68xoyi.fsf@duaron.myhome.or.jp>
	<20061201050852.GA31347@wotan.suse.de>
	<20061130232102.0cc7fc0b.akpm@osdl.org>
	<20061201075341.GB31347@wotan.suse.de>
	<87slfzu0ty.fsf@duaron.myhome.or.jp> <4570CA90.8050203@yahoo.com.au>
	<20061202072822.GA5911@wotan.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 02 Dec 2006 18:43:05 +0900
In-Reply-To: <20061202072822.GA5911@wotan.suse.de> (Nick Piggin's message of "Sat\, 2 Dec 2006 08\:28\:22 +0100")
Message-ID: <87vekuskeu.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

>> I see. I guess you need to synchronise your writepage versus this
>> extention in order to handle it properly then. I won't bother with
>> that though: it won't be worse than it was before.
>> 
>> Thanks for review, do you agree with the other hunks?
>
> Well, Andrew's got the rest of the patches in his tree, so I'll send
> what we've got for now. Has had some testing on both reiserfs and
> fat. Doesn't look like the other filesystems using cont_prepare_write
> will have any problems...
>
> Andrew, please apply this patch as a replacement for the fat-fix
> patch in your rollup (this patch includes the same fix, and is a
> more logical change unit I think).

I'm confused. I couldn't track what is final patchset. Anyway, I'll
see and test your final patchset in -mm.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
