Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbTCZKHA>; Wed, 26 Mar 2003 05:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCZKHA>; Wed, 26 Mar 2003 05:07:00 -0500
Received: from [12.47.58.83] ([12.47.58.83]:34784 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261283AbTCZKG7>;
	Wed, 26 Mar 2003 05:06:59 -0500
Date: Wed, 26 Mar 2003 02:18:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ENBD for 2.5.64
Message-Id: <20030326021842.6248625b.akpm@digeo.com>
In-Reply-To: <20030326095915.GL3413@marowsky-bree.de>
References: <3E81132C.9020506@pobox.com>
	<200303252053.h2PKrRn09596@oboe.it.uc3m.es>
	<3E81132C.9020506@pobox.com>
	<5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
	<20030326095915.GL3413@marowsky-bree.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 10:18:03.0431 (UTC) FILETIME=[FC50C370:01C2F380]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> wrote:
>
> In particular with ENBD, a partial write could occur at the block device
> layer. Now try to report that upwards to the write() call. Good luck.

Well you can't, unless it is an O_SYNC or O_DIRECT write...

But yes, for a normal old write() followed by an fsync() the IO error can be
lost.  We'll fix this for 2.6.  I have oxymoron's patches lined up, but they
need a couple of quality hours' worth of thinking about yet.


