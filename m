Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276815AbSIVI0g>; Sun, 22 Sep 2002 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276866AbSIVI0g>; Sun, 22 Sep 2002 04:26:36 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:1704 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S276815AbSIVI0g> convert rfc822-to-8bit; Sun, 22 Sep 2002 04:26:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Sun, 22 Sep 2002 10:30:32 +0200
User-Agent: KMail/1.4.1
References: <597807912.1032600740@[10.10.2.3]> <20020921231810.GA25605@holomorphy.com> <20020922080942.GF25605@holomorphy.com>
In-Reply-To: <20020922080942.GF25605@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209221030.32323.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

would you please check the boot messages for the NUMA scheduler before
doing the run. Martin sent me an example where he has:

CPU pools : 1
pool 0 :0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
node level 0 : 10
pool_delay matrix:
 129 

which is clearly wrong. In that case we need to fix the cpu-pools setup
first.

Regards,
Erich

On Sunday 22 September 2002 10:09, William Lee Irwin III wrote:
> On Sat, Sep 21, 2002 at 09:46:05AM -0700, Martin J. Bligh wrote:
> >> An old compile off 2.5.31-mm1 + extras (I don't have 37, but similar)
>
> On Sat, Sep 21, 2002 at 04:18:10PM -0700, William Lee Irwin III wrote:
> > Some 8-quad numbers for 2.5.37 (virgin) follow.
>
> Okay, 2.5.37 virgin with overcommit_memory set to 1 this time.
> (compiles with -j256 seem to do better than -j32 or -j48, here is -j256):
>
> ... will follow up with 2.5.38-mm1 with and without NUMA sched, at
> least if the arrival rate of releases doesn't exceed the benchtime.

