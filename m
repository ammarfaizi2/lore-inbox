Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSLQRUG>; Tue, 17 Dec 2002 12:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSLQRUG>; Tue, 17 Dec 2002 12:20:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:40703 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265135AbSLQRUE>;
	Tue, 17 Dec 2002 12:20:04 -0500
Message-ID: <3DFF5E67.C0BA874C@digeo.com>
Date: Tue, 17 Dec 2002 09:27:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move LOG_BUF_SIZE to header file
References: <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Dec 2002 17:27:56.0693 (UTC) FILETIME=[A366F450:01C2A5F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> ...
> One other thing that I considered doing was using a common
> Kconfig file for all 20 arch'es by adding a
>   source "kernel/Kconfig"
> at the end of each <arch>/Kconfig file.  This would provide
> a common "General setup (more)" that could be used after most
> config options are set instead of near the top of the menu.
> Does that make sense to anybody?
> 

I think so.  There are times when one wants to add arch-neutral
config items which just don't logically fit into any of the
existing menus.  The right place to put the item is into each
and every architecture's arch/<arch>/Kconfig, and that's plain
silly.
