Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264007AbTCYWx3>; Tue, 25 Mar 2003 17:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbTCYWx3>; Tue, 25 Mar 2003 17:53:29 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:1946 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264007AbTCYWx2>; Tue, 25 Mar 2003 17:53:28 -0500
Date: Wed, 26 Mar 2003 00:04:32 +0000
From: norbert_wolff@t-online.de (Norbert Wolff)
To: linux-kernel@vger.kernel.org
Cc: jds@soltis.cc
Subject: Re: Problems when boot new kernel 2.5.66 kernel panic
Message-Id: <20030326000432.01155a86.norbert_wolff@t-online.de>
In-Reply-To: <20030325190214.M66226@soltis.cc>
References: <20030325190214.M66226@soltis.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003 13:13:07 -0600
"jds" <jds@soltis.cc> wrote:

>    VFS: Cannot open root device "rootvg/lvol1" or unknown-block(0,0)
>    Please append a coorect "root=" boot option
>    kernel panic
>    VFS= Unable to mount fs on unknown-block(0,0).

I've exactly the the same Problem here, Kernel 2.5.66, no modules, no raid,
no lvm, tried with devfs and without it

	VFS:  Cannot open root device "301" or ide(3,1) <-- this IS my /dev/hda1
	kernel panic

- sys_mknod in mount_root for device 301 succeeds, but
- sys_mount in do_mount_root returns ENOENT for "/dev/root"

Kernel 2.5.65 compiled with the same Config-Options and the same compiler boots
correctly.

Any Suggestions ?

	Norbert
