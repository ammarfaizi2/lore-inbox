Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbTCLIgZ>; Wed, 12 Mar 2003 03:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263094AbTCLIgZ>; Wed, 12 Mar 2003 03:36:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:11422 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263092AbTCLIgZ>;
	Wed, 12 Mar 2003 03:36:25 -0500
Date: Wed, 12 Mar 2003 00:48:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix big initramfs (was: [PATCH] gen_init_cpio fixes for
 2.5.64)
Message-Id: <20030312004801.527dfdf1.akpm@digeo.com>
In-Reply-To: <20030312082203.GA22432@h55p111.delphi.afb.lu.se>
References: <20030305060817.GC26458@kroah.com>
	<20030308004249.GA23071@kroah.com>
	<20030308004340.GB23071@kroah.com>
	<20030308143745.GB7234@h55p111.delphi.afb.lu.se>
	<20030309060452.GA28835@kroah.com>
	<20030312082203.GA22432@h55p111.delphi.afb.lu.se>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 08:47:02.0270 (UTC) FILETIME=[F36D39E0:01C2E873]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson <andersg@0x63.nu> wrote:
>
> Patch below makes the call to page_writeback_init() explicit in
> start_kernel, just before populate_rootfs().
> 

Fair enough.

> +extern void page_writeback_init(void);

But please don't put declarations of external functions into .c.  It is
always the wrong thing to do, even though others have done it...

writeback.h is a fine place for this declaration.
