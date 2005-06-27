Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVF0QBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVF0QBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVF0PTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:19:45 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:59145 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261472AbVF0Omr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:42:47 -0400
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@gentoo.org: [Bug 93671] mount uses wrong default umask for fat filesystem]
References: <20050627100746.GC24093@kestrel>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 27 Jun 2005 23:42:37 +0900
In-Reply-To: <20050627100746.GC24093@kestrel> (Karel Kulhavy's message of "Mon, 27 Jun 2005 12:07:46 +0200")
Message-ID: <87br5r509u.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy <clock@twibright.com> writes:

> ------- Additional Comments From stian@nixia.no  2005-06-26 16:36 PDT -------
> This is not a mount bug, but a kernel-bug. umask=nnn is passed along other
> user-flags to the mount syscall as a string, and the kernel-filesystem driver
> parses the string and denies the syscall if a syntax-error occures. Not all
> filesystems supports umask, so umask is not sent unless spesified. If the mount
> man-page claims that umask is defaulted to the current shell umask setting, the
> kernel-driver needs to take this into account when umask isn't found in the
> string it receives from user-space. Just my 5 cent about this bug

Look util-linux-2.12q... hm, mount command is reseting the umask in main().
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
