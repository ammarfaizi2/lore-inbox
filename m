Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSH1AzF>; Tue, 27 Aug 2002 20:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSH1AzF>; Tue, 27 Aug 2002 20:55:05 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:43269
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318536AbSH1AzD>;
	Tue, 27 Aug 2002 20:55:03 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2002 17:59:09 -0700
Subject: Re: [PATCH] sched.c
Message-ID: <3D6BBDED.28599.4E361C@localhost>
References: <E17jqSE-0002jN-00@starship>
In-reply-to: <E17jqzU-0002jv-00@starship>
X-mailer: Pegasus Mail for Windows (v4.02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Empty post?]

On 28 Aug 2002 at 2:47, Daniel Phillips wrote:

> On Wednesday 28 August 2002 02:13, Daniel Phillips wrote:
> > On Tuesday 27 August 2002 20:35, Andrew Morton wrote:
> > > Lahti Oy wrote:
> > > > - for (i = 0; i < NR_CPUS; i++)
> > > > + for (i = NR_CPUS; i; i--)
> > > >    sum += cpu_rq(i)->nr_running;
> > > 
> > > Off-by-one there.  You'd want
> > > 
> > > 	for (i = NR_CPUS; --i >= 0; )
> > > 
> > > or something similarly foul ;)
> > 
> > 	int i = NR_CPUS;
> > 
> > 	while (--i)

for (i = NR_CPUS - 1; i >= 0; i--)

unless i is unsigned...
