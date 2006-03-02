Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWCBSOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWCBSOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWCBSOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:14:48 -0500
Received: from mail.parknet.jp ([210.171.160.80]:63754 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932426AbWCBSOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:14:48 -0500
X-AuthUser: hirofumi@parknet.jp
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
References: <op.s5lrw0hrj68xd1@mail.piments.com>
	<200603020845.10083.mason@suse.com>
	<87u0ahszxa.fsf@duaron.myhome.or.jp>
	<200603021201.32653.mason@suse.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 03 Mar 2006 03:14:34 +0900
In-Reply-To: <200603021201.32653.mason@suse.com> (Chris Mason's message of "Thu, 2 Mar 2006 12:01:31 -0500")
Message-ID: <873bi0sohh.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> Ok, I thought you were asking about the code that called filemap_fdatawrite, 
> which does wait.  filemap_flush is used on the underlying block device.  In 
> the case of a page that is already under IO, the io is not cancelled but 
> allowed to continue.
>
> This is the desired result.  When you're doing a number of operations in 
> sequence, each operation will start io on the block device.  If they used 
> filemap_fdatawrite instead of filemap_flush, they would end up being 
> synchronous.

Of course, I know. Let's return to beginning of this thread, do you have
any plan to address it?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
