Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbTLFT5e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbTLFT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:57:32 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:19976 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265137AbTLFT5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:57:31 -0500
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FIx  'noexec' behavior
References: <20031206191829.23188.qmail@web14904.mail.yahoo.com>
	<3FD22F5D.1000806@redhat.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 07 Dec 2003 04:57:14 +0900
In-Reply-To: <3FD22F5D.1000806@redhat.com>
Message-ID: <87n0a590th.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

	if (file && (!file->f_op || !file->f_op->mmap))
		return -ENODEV;

	if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
		return -EPERM;

Probably he get the oops, because file can be NULL.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
