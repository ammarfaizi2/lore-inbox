Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262351AbSJLIDE>; Sat, 12 Oct 2002 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSJLIDE>; Sat, 12 Oct 2002 04:03:04 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:54211 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262351AbSJLIDD> convert rfc822-to-8bit; Sat, 12 Oct 2002 04:03:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple NUMA Scheduler - rev 2
Date: Sat, 12 Oct 2002 10:03:45 +0200
User-Agent: KMail/1.4.1
Cc: mbligh@arcanet.com, habanero@us.ibm.com
References: <1034207779.9367.595.camel@dyn9-47-17-164.beaverton.ibm.com> <4450000.1034371619@flay>
In-Reply-To: <4450000.1034371619@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121003.45856.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

what is the cache_decay_ticks value for these results? Is it the
default (i.e. = 0 )?

Erich

On Friday 11 October 2002 23:26, Martin J. Bligh wrote:
> > Comments?
>
> OK, that's the first one that looks better to me across the board in both
> kernbench and Eric's tests - congrats .... do_schedule seems to be a little
> slow, not sure if that's fixable or not. Will test Erich's new stuff this
> evening (I hope).
>
> (lower numbers are better).
>
> Kernbench:
>                              Elapsed        User      System         CPU
>               2.5.41-mm3     19.946s     192.44s      44.15s       1186%
>   2.5.41-mm3-sched41rev1      20.07s    190.058s     43.434s     1163.2%
>
> Schedbench 4:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.41-mm3       33.80       48.12      135.24        0.74
>   2.5.41-mm3-sched41rev1       22.42       37.08       89.70        0.65
>
> Schedbench 8:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.41-mm3       46.92       81.47      375.44        1.65
>   2.5.41-mm3-sched41rev1       31.09       45.17      248.81        1.59
>
> Schedbench 16:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.41-mm3       64.81       82.92     1037.24        5.55
>   2.5.41-mm3-sched41rev1       51.79       63.72      828.76        4.58
>
> Schedbench 32:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.41-mm3       95.36      223.18     3052.02       12.57
>   2.5.41-mm3-sched41rev1       55.42      123.27     1773.77        7.83
>
> Schedbench 64:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.41-mm3      156.15      638.75     9994.56       27.37
>   2.5.41-mm3-sched41rev1       57.92      256.19     3707.48       16.90
>
> ----------------------

