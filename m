Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423484AbWJaPWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423484AbWJaPWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423486AbWJaPWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:22:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7903 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423484AbWJaPWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:22:40 -0500
Message-ID: <45476A36.2020405@redhat.com>
Date: Tue, 31 Oct 2006 09:22:30 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH] fix UFS superblock alignment issues
References: <4546C701.9020707@redhat.com>
In-Reply-To: <4546C701.9020707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> ufs2 fails to mount on x86_64, claiming bad magic.  This is because 
> ufs_super_block_third's fs_un1 member is padded out by 4 bytes for
> 8-byte alignment, pushing down the rest of the struct.
> 
> Forcing this to be packed solves it.  I took a quick look over
> other on-disk structures and didn't immediately find other problems.
> I was able to mount & ls a populated ufs2 filesystem w/ this change.

I should also mention that this seems to be a regression from
2.6.17->2.6.18, so perhaps it's a candidate for 2.6.18.x updates.

Thanks,

-Eric
