Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755277AbWKVQPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbWKVQPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbWKVQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:15:49 -0500
Received: from mail.parknet.jp ([210.171.160.80]:53767 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1755277AbWKVQPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:15:49 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 01:15:46 +0900
In-Reply-To: <20061122163001.0d291978@localhost> (The Peach's message of "Wed\, 22 Nov 2006 16\:30\:01 +0100")
Message-ID: <8764d7v4nh.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Peach <smartart@tiscali.it> writes:

> and the copy of an "abnormal" file:
>
> # cp -v DSCN5980.JPG /mnt/loop/
> `DSCN5980.JPG' -> `/mnt/loop/DSCN5980.JPG'
>
> and its dmesg output:
> vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
> vfat_hashi: parent /, name DSCN5980.JPG
> vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
> vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
> vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
> vfat_hashi: parent /, name DSCN5980.JPG
> vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
> vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
> vfat_create: name dscn5980.jpg
> vfat_add_entry: 0: DSCN5980, JPG
> vfat_add_entry: 1: dscn5, 980.jp, g
> vfat_create: err 0

This seems to be nasty problem of dentry cache handling.

>> And if you comment-in the
>> following parts, does this problem fix?
>
> I will repatch asap and post the result.

Thanks. Probably instead of some overheads, this patch will fix a problem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
