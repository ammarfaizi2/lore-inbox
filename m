Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263546AbSIQDMY>; Mon, 16 Sep 2002 23:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbSIQDMX>; Mon, 16 Sep 2002 23:12:23 -0400
Received: from packet.digeo.com ([12.110.80.53]:54714 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263546AbSIQDMW>;
	Mon, 16 Sep 2002 23:12:22 -0400
Message-ID: <3D869EAF.663B6EC3@digeo.com>
Date: Mon, 16 Sep 2002 20:17:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: false NUMA OOM
References: <20020917025035.GY2179@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 03:17:03.0578 (UTC) FILETIME=[B1C893A0:01C25DF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> +       for (type = classzone - first_classzone; type >= 0; --type)
> +               for_each_pgdat(pgdat) {
> +                       zone = pgdat->node_zones + type;

Well you'd want to start with (and prefer) the local node's zones?

I'm also wondering whether one shouldn't just poke a remote kswapd
and wait.
