Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbSIQUu4>; Tue, 17 Sep 2002 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbSIQUu4>; Tue, 17 Sep 2002 16:50:56 -0400
Received: from packet.digeo.com ([12.110.80.53]:9428 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264520AbSIQUu4>;
	Tue, 17 Sep 2002 16:50:56 -0400
Message-ID: <3D8796D5.A4ACD5FA@digeo.com>
Date: Tue, 17 Sep 2002 13:55:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: TLB flush counters gone in 2.5.35-bk?
References: <3D874DA1.20803@drugphish.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 20:55:49.0379 (UTC) FILETIME=[9A1C8D30:01C25E8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> 
> Hello,
> 
> I was just browsing over the latest bk tree when I saw the following change:
> 
> ...
> -       unsigned long           flushes;/* stats: count avoided flushes */
> -       unsigned long           avoided_flushes;

That was some statistical/debug code to evaluate how useful
that particular optimisation was being.  Answer: it saves
30-35% of the global TLB invalidations coming out of there.

But it had served its purpose.
