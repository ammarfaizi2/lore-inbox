Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAAUce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAAUce (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAAUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 15:32:34 -0500
Received: from hera.kernel.org ([209.128.68.125]:55508 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261177AbVAAUc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 15:32:28 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: initramfs: is it supposed to work?
Date: Sat, 1 Jan 2005 20:31:42 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cr71be$1sv$1@terminus.zytor.com>
References: <41D4A2A6.3060607@tls.msk.ru> <cr319b$31b$1@terminus.zytor.com> <pan.2005.01.01.15.40.12.264342@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104611502 1952 127.0.0.1 (1 Jan 2005 20:31:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 1 Jan 2005 20:31:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <pan.2005.01.01.15.40.12.264342@dungeon.inka.de>
By author:    Andreas Jellinghaus <aj@dungeon.inka.de>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> run-init seems to mount the new root, rm files in the old root,
> mount, chroot, open the console, exec. any reason we can't do
> that in shell script commands?
>  
> > You don't pivot_root initramfs, because initramfs *IS* rootfs.
> > 
> > Instead, use the run-init program
> 
> ok, but still: is it ok for the kernel to die?
> after all pivot_root works fine, unless /initrd is unmounted.
> what exactly is the kernel internal that makes pivot_root special?
> 

Your /initrd here is rootfs, and by unmounting rootfs, you've pulled
the rug out from underneath the kernel any time it needs to spawn a
kernel thread.

	-hpa
