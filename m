Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUHDNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUHDNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUHDNbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:31:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:9744 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265429AbUHDNbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:31:23 -0400
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-bk] New read/write bug in FAT fs
References: <4110CF29.8060401@myrealbox.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 04 Aug 2004 22:31:18 +0900
In-Reply-To: <4110CF29.8060401@myrealbox.com>
Message-ID: <87657zkp21.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt <wa1ter@myrealbox.com> writes:

> One of the changesets posted by Linus on August 2 introduced
> a bug in the FAT fs:
> 
> Even when a fat32 fs is mounted read-write I now get error
> messages claiming the fs is 'read-only' when I try to write
> to it.
> 
> The only change I can see which fits the timing is to inode.c
> which was posted on August 2.  Apologies if I am blaming
> the wrong changeset.
> 
> Could someone confirm this bug for me?

This is intention.

The default codepage/iocharset which is easy to cause a mistake and
unclear was deleted from fatfs. So default is mounted as read only.

You need to explicitly specify the "codepage" and "iocharset" options.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
