Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUHVMaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUHVMaG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUHVMaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:30:06 -0400
Received: from mail1.ewetel.de ([212.6.122.12]:55505 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S266721AbUHVMaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:30:02 -0400
To: nf2@scheinwelt.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nonotify 0.3.2 (A simple dnotify replacement)
In-Reply-To: <2vRn8-1D3-9@gated-at.bofh.it>
References: <2vRn8-1D3-9@gated-at.bofh.it>
Date: Sun, 22 Aug 2004 14:29:59 +0200
Message-Id: <E1ByrTz-00003r-8U@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 05:40:06 +0200, you wrote in linux.kernel:

> 2) The /dev/nonotify device:
>
> /dev/nonotify has the only purpose to offer a special stat() call via
> ioctl to read the contents_mtime field of directories (together with
> atime, mtime, ctime). The client has to set the 'filename' field of the
> 'nonotify_stat' structure and receives the four timespec fields updated
> via ioctl.

A lot of people here (Linus, for instance) frown on ioctl() interfaces.
They're hard to do right in 32/64bit compat layers, for example. How
about using a syscall interface instead?

-- 
Ciao,
Pascal
