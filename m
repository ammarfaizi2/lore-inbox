Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269324AbTCDH7p>; Tue, 4 Mar 2003 02:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269325AbTCDH7p>; Tue, 4 Mar 2003 02:59:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:41609 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269324AbTCDH7n>;
	Tue, 4 Mar 2003 02:59:43 -0500
Date: Tue, 4 Mar 2003 00:10:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
Message-Id: <20030304001032.034f60fa.akpm@digeo.com>
In-Reply-To: <200303041354.03428.kernel@kolivas.org>
References: <200303041354.03428.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 08:10:05.0833 (UTC) FILETIME=[7705C790:01C2E225]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Mem_load result of AS being slower was just plain weird with the result rising 
> from 100 to 150 during testing.
> 

Maybe we should just swap computers or something?

Finished compiling kernel: elapsed: 145 user: 180 system: 18
Finished mem_load: elapsed: 146 user: 0 system: 2 loads: 5000
Finished compiling kernel: elapsed: 135 user: 181 system: 17
Finished mem_load: elapsed: 136 user: 0 system: 2 loads: 4800
Finished compiling kernel: elapsed: 129 user: 181 system: 17
Finished mem_load: elapsed: 130 user: 0 system: 2 loads: 4800

256MB, dual CPU, ext3/IDE.

Whereas 2.5.63+bk gives:

Finished compiling kernel: elapsed: 131 user: 182 system: 17
Finished mem_load: elapsed: 131 user: 0 system: 1 loads: 4900
Finished compiling kernel: elapsed: 135 user: 182 system: 17
Finished mem_load: elapsed: 135 user: 0 system: 1 loads: 4800
Finished compiling kernel: elapsed: 129 user: 182 system: 17
Finished mem_load: elapsed: 129 user: 0 system: 1 loads: 4600

Conceivably swap fragmentation, but unlikely.  Is it still doing a swapoff
between runs?
