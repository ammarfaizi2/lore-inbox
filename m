Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbUKXTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUKXTNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUKXTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:13:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27410 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262799AbUKXTMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:12:40 -0500
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87pt23wdk1.fsf@devron.myhome.or.jp>
	<20041124160251.6dabbc92@pirandello>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Nov 2004 03:10:48 +0900
In-Reply-To: <20041124160251.6dabbc92@pirandello> (Colin Leroy's message of
 "Wed, 24 Nov 2004 16:02:51 +0100")
Message-ID: <87d5y3w21j.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy <colin@colino.net> writes:

> On 24 Nov 2004 at 23h11, OGAWA Hirofumi wrote:
>
> Hi, 
>
>> Aren't you forgetting to update the inode and various metadata (e.g. FAT)?
>
> Don't really know what to do about this one; where should I look ?
>
> this second patch seems a step in the right direction to me, based off your
> previous comments:

Ah, I understood the intention of that code now. Probably we would
need the following for writing inode.

int fat_sync_inode(struct inode *inode)
{
	return fat_write_inode(inode, 1);
}

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
