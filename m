Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278171AbRJLWKk>; Fri, 12 Oct 2001 18:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278172AbRJLWKZ>; Fri, 12 Oct 2001 18:10:25 -0400
Received: from peace.netnation.com ([204.174.223.2]:54802 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S278171AbRJLWKD>; Fri, 12 Oct 2001 18:10:03 -0400
Date: Fri, 12 Oct 2001 15:10:33 -0700
From: Simon Kirby <sim@netnation.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
Message-ID: <20011012151033.B12311@netnation.com>
In-Reply-To: <20011011114736.A13722@netnation.com> <200110111930.XAA28404@ms2.inr.ac.ru> <20011011125538.C10868@netnation.com> <k2sncok4z2.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <k2sncok4z2.fsf@zero.aec.at>; from andi@firstfloor.org on Fri, Oct 12, 2001 at 09:56:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 09:56:01PM +0200, Andi Kleen wrote:

> The hash table is likely to big anyways; eating cache and not helping that
> much. If you're interested in some testing
> I can send you patches to change it by hand and collect statistics for
> average hash queue length. Then you can figure out a good size for your
> workload with some work. Longer time I think the table sizing heuristics
> are far too aggressive and need to be throttled back; but that needs more
> data from real servers.

Wouldn't just counting the lines in /proc/net/tcp be sufficient to see
how many buckets should be used in an ideal hash table distribution
scenario?  (In which case the size of the hash table depends largely on a
machine's work load...)

Most of our web servers seem to have 500-1000 entries in /proc/net/tcp.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
