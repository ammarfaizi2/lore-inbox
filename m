Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVCMMWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVCMMWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCMMWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:22:50 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:50961 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261181AbVCMMWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:22:47 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: chaffee@bmrc.berkeley.edu, <mc@cs.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] sync doesn't flush everything out (msdos and vfat,
 2.6.11)
References: <Pine.GSO.4.44.0503122205270.4831-100000@elaine24.Stanford.EDU>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Mar 2005 21:22:29 +0900
In-Reply-To: <Pine.GSO.4.44.0503122205270.4831-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Sat, 12 Mar 2005 22:07:30 -0800 (PST)")
Message-ID: <877jkb3fcq.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

> /å004  and
> /0005
>   share clusters.
>   Truncating second to 0 bytes.
> /0005
>   File size is 4 bytes, cluster chain length is 0 bytes.
>   Truncating file to 0 bytes.
> Performing changes.
> /dev/sbd0: 5 files, 4/8167 clusters
>
> This causes file /0005 to be truncated to 0.

The 0004 seems to be already deleted directory actually, because first
char is 0xE5 (0xE5 is deleted mark).

Please download fixed dosfsck
   http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
