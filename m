Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWDYAFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWDYAFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDYAFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:05:36 -0400
Received: from ns.mimer.no ([213.184.200.1]:25581 "EHLO odin.mimer.no")
	by vger.kernel.org with ESMTP id S932107AbWDYAFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:05:35 -0400
From: Harald Arnesen <harald@skogtun.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
	<20060425001617.0a536488@werewolf.auna.net>
Date: Tue, 25 Apr 2006 02:05:29 +0200
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net> (J. A. Magallon's
	message of "Tue, 25 Apr 2006 00:16:17 +0200")
Message-ID: <87iroyr03a.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:

> Tell me what is the difference between:
>
>
>     sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
>     if (!sbi)
>         return -ENOMEM;
>     sb->s_fs_info = sbi;
>     memset(sbi, 0, sizeof(*sbi));
>     sbi->s_mount_opt = 0;
>     sbi->s_resuid = EXT3_DEF_RESUID;
>     sbi->s_resgid = EXT3_DEF_RESGID;
>
> and
>
>     SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
>     {}
>
>     ...
>     sbi = new SuperBlock;
>     if (!sbi)
>         return -ENOMEM;
>
> apart that you don't get members initalized twice and get a shorter code :).

The former is easier to read and understand?
-- 
Hilsen Harald.

