Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbSLRS6z>; Wed, 18 Dec 2002 13:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267341AbSLRS6y>; Wed, 18 Dec 2002 13:58:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:17082 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267340AbSLRS6x>;
	Wed, 18 Dec 2002 13:58:53 -0500
Message-ID: <3E00C742.E682A93A@digeo.com>
Date: Wed, 18 Dec 2002 11:06:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2.5;v3) move LOG_BUF_SIZE to header/config
References: <Pine.LNX.4.33L2.0212181013470.21858-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 19:06:47.0112 (UTC) FILETIME=[9C9ED480:01C2A6C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Linus,
> 
> Patch applies to 2.5.52-bk3.
> 
> This makes LOG_BUF_LEN (actually its shift value) a configurable
> parameter.  It does this by adding a general/common config file
> that can use processor-related dependencies.  This new Kconfig file
> is located in linux/kernel/ and is included at the end of each
> arch/*/Kconfig file.
> 
> Modified to address comments from Christoph Hellwig, James Cloos,
> and Andrew Morton, who likes it.
> 

The reason I like it is that it adds $TOPDIR/kernel/Kconfig.  Several
times I've been confronted with the need to put exactly the same thing
into each and every arch/<arch>/Kconfig.  There doesn't seem to be a
single all-architectures "general stuff" place at present.
