Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318392AbSH1AlQ>; Tue, 27 Aug 2002 20:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSH1AlO>; Tue, 27 Aug 2002 20:41:14 -0400
Received: from dsl-213-023-020-028.arcor-ip.net ([213.23.20.28]:15301 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318392AbSH1AlM>;
	Tue, 27 Aug 2002 20:41:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Lahti Oy <rlahti@netikka.fi>
Subject: Re: [PATCH] sched.c
Date: Wed, 28 Aug 2002 02:47:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran> <3D6BC685.216B5B67@zip.com.au> <E17jqSE-0002jN-00@starship>
In-Reply-To: <E17jqSE-0002jN-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jqzU-0002jv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 02:13, Daniel Phillips wrote:
> On Tuesday 27 August 2002 20:35, Andrew Morton wrote:
> > Lahti Oy wrote:
> > > - for (i = 0; i < NR_CPUS; i++)
> > > + for (i = NR_CPUS; i; i--)
> > >    sum += cpu_rq(i)->nr_running;
> > 
> > Off-by-one there.  You'd want
> > 
> > 	for (i = NR_CPUS; --i >= 0; )
> > 
> > or something similarly foul ;)
> 
> 	int i = NR_CPUS;
> 
> 	while (--i)

Err, i--

-- 
Daniel
