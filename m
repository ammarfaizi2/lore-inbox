Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSKIC35>; Fri, 8 Nov 2002 21:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbSKIC35>; Fri, 8 Nov 2002 21:29:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:56736 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264614AbSKIC34>;
	Fri, 8 Nov 2002 21:29:56 -0500
Message-ID: <3DCC74B0.47A462A9@digeo.com>
Date: Fri, 08 Nov 2002 18:36:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>, Jens Axboe <axboe@suse.de>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <200211091300.32127.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2002 02:36:32.0826 (UTC) FILETIME=[D0D601A0:01C28798]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              474.1   15      36      10      6.64
> 2.4.19 [3]              492.6   14      38      10      6.90
> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
> 

2.4.20-pre3 included some elevator changes.  I assume they are the
cause of this.  Those changes have propagated into Alan's and Andrea's
kernels.   Hence they have significantly impacted the responsiveness
of all mainstream 2.4 kernels under heavy writes.

(The -ck patch includes rmap14b which includes the read-latency2 thing)
