Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKTHCy>; Wed, 20 Nov 2002 02:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbSKTHCy>; Wed, 20 Nov 2002 02:02:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:32653 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265880AbSKTHCx>;
	Wed, 20 Nov 2002 02:02:53 -0500
Message-ID: <3DDB353F.33D826C8@digeo.com>
Date: Tue, 19 Nov 2002 23:09:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Thorbj=F8rn?= Lind <mtl@slowbone.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.48-bk, md raid0 fix
References: <3DDAE54F.4010808@slowbone.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Nov 2002 07:09:51.0790 (UTC) FILETIME=[D1EC94E0:01C29063]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorbjørn Lind wrote:
> 
> Fixes the 'BUG at drivers/block/ll_rw_blk.c:19xx' when using raid0 md devices since 2.5.45...
> 
> ...
> +       max_size = mddev->chunk_size - ((bio->bi_sector % (mddev->chunk_size >> 9)) << 9);

The mod operator on a 64-bit quantity won't work with
CONFIG_LBD=y, will it?
