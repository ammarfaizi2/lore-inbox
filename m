Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUGLNTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUGLNTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUGLNTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:19:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:29193 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266824AbUGLNTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:19:33 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<Pine.GSO.4.58.0407121356510.17199@waterleaf.sonytel.be>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 12 Jul 2004 22:18:13 +0900
In-Reply-To: <Pine.GSO.4.58.0407121356510.17199@waterleaf.sonytel.be>
Message-ID: <87pt71jre2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Sun, 11 Jul 2004, Linus Torvalds wrote:
> > Hirofumi Ogawa:
> >   o FAT: don't use "utf8" charset and NLS_DEFAULT
> 
> This patch breaks compilation if both MSDOS_FS and VFAT_FS are not set, due to
> CONFIG_FAT_DEFAULT_CODEPAGE being undefined.
> 
> Suggested fix: either make FAT_DEFAULT_CODEPAGE depend on FAT_FS only
> (compilation of fs/fat/inode.c depends on FAT_FS), or add a test for
> CONFIG_FAT_DEFAULT_CODEPAGE being undefined, cfr. the test for
> CONFIG_FAT_DEFAULT_IOCHARSET in fs/fat/inode.c.

Why did you need only FAT_FS? If it was not needed, I'll remove the
configurable FAT_FS, instead it is internally used only.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
