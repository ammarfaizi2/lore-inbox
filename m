Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSJHJKB>; Tue, 8 Oct 2002 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJHJKB>; Tue, 8 Oct 2002 05:10:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:32462 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261567AbSJHJKB>;
	Tue, 8 Oct 2002 05:10:01 -0400
Message-ID: <3DA2A233.88525FE4@digeo.com>
Date: Tue, 08 Oct 2002 02:15:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: experiences with 2.5.40 on a busy usenet news server
References: <anu60s$oev$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 09:15:35.0147 (UTC) FILETIME=[425A43B0:01C26EAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> ...
> # free
>              total       used       free     shared    buffers     cached
> Mem:       1033308    1027316       5992          0     836884      29776
> -/+ buffers/cache:     160656     872652
> Swap:       976888     364032     612856

Please always send /proc/meminfo - it's way more informative.

A vmstat trace is also useful.
 
> No need to swap 364 MB when there's 872 MB still free...
> This makes the machine dogslow. An 'expire' process that
> runs every night normally takes 15 minutes to finish now
> has been running for 10 hours and its still not finished.

It must be doing a ton of IO?

You'll probably find that 2.5.41-mm1 does not swap at all; but
I'd need to see meminfo to know.
