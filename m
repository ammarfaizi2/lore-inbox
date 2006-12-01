Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758593AbWLADr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593AbWLADr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758823AbWLADr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:47:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33478 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758596AbWLADr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:47:28 -0500
Date: Fri, 1 Dec 2006 04:47:26 +0100
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201034726.GA26520@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp> <20061201020910.GC455@wotan.suse.de> <87mz68xoyi.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mz68xoyi.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:41:25PM +0900, OGAWA Hirofumi wrote:
> Nick Piggin <npiggin@suse.de> writes:
> >
> > So basically this is changing from having prepare_write do all the
> > zeroing, to zeroing the last page in generic_cont_expand, so that
> > we don't have to pass a zero-length to prepare_write?
> 
> Yes, this patch doesn't pass zero-length to prepare_write. However,
> I'm not checking this patch is ok for reiserfs...

OK, I'm doing some testing with it now...

