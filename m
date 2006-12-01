Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758875AbWLAPrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbWLAPrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759281AbWLAPrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:47:31 -0500
Received: from mail.parknet.jp ([210.171.160.80]:18700 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1758875AbWLAPra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:47:30 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072058.GA18004@wotan.suse.de>
	<20061130072202.GB18004@wotan.suse.de>
	<20061130072247.GC18004@wotan.suse.de>
	<20061130113241.GC12579@wotan.suse.de>
	<87r6vkzinv.fsf@duaron.myhome.or.jp>
	<20061201020910.GC455@wotan.suse.de>
	<87mz68xoyi.fsf@duaron.myhome.or.jp>
	<20061201050852.GA31347@wotan.suse.de>
	<20061130232102.0cc7fc0b.akpm@osdl.org>
	<20061201075341.GB31347@wotan.suse.de>
	<87slfzu0ty.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 02 Dec 2006 00:47:23 +0900
In-Reply-To: <87slfzu0ty.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Fri\, 01 Dec 2006 23\:50\:49 +0900")
Message-ID: <877ixbty7o.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Ah, unfortunately we can't this. If we don't update ->i_size before
> page_cache_release, pdflush will think these pages is outside ->i_size
> and just clean the page without writing it.

Ugh, of course, s/page_cache_release/unlock_page/
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
