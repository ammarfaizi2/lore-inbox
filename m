Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbTAGLSJ>; Tue, 7 Jan 2003 06:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbTAGLSJ>; Tue, 7 Jan 2003 06:18:09 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:52390 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265187AbTAGLSI> convert rfc822-to-8bit; Tue, 7 Jan 2003 06:18:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
Date: Tue, 7 Jan 2003 12:27:09 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <234590000.1041833252@titus> <1041906222.21653.50.camel@kenai>
In-Reply-To: <1041906222.21653.50.camel@kenai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301071227.09985.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael and Martin,

thanks a lot for the testing!

I rechecked the changes and really don't see any reason for a
slowdown. Michael's measurements seem to confirm that this is just a
statistical effect. I suggest: when in doubt, do 10 kernel compiles
instead of 5. A simple statistical error estimation as I did for
schedbench might help, too. Guess I've sent you the script a while
ago.

I understand from your emails that the 2.5.53 patches apply and work
for 2.5.54, therefore I'll wait for 2.5.55 with a rediff.

Regards,
Erich


On Tuesday 07 January 2003 03:23, Michael Hohnbaum wrote:
> On Sun, 2003-01-05 at 22:07, Martin J. Bligh wrote:
> > >> > Kernbench:
> > >> >                         Elapsed       User     System        CPU
> > >> >              sched50     29.96s   288.308s    83.606s    1240.8%
> > >> >              sched52    29.836s   285.832s    84.464s    1240.4%
> > >> >              sched53    29.364s   284.808s    83.174s    1252.6%
> > >> >              stock50    31.074s   303.664s    89.194s    1264.2%
> > >> >              stock53    31.204s   306.224s    87.776s    1263.2%
> > >
> > > sched50 = linux 2.5.50 with the NUMA scheduler
> > > sched52 = linux 2.5.52 with the NUMA scheduler
> > > sched53 = linux 2.5.53 with the NUMA scheduler
> > > stock50 = linux 2.5.50 without the NUMA scheduler
> > > stock53 = linux 2.5.53 without the NUMA scheduler
> >
> > I was doing a slightly different test - Erich's old sched code vs the new
> > both on 2.5.54, and seem to have a degredation.
> >
> > M.
>
> Martin,
>
> I ran 2.5.54 with an older version of Erich's NUMA scheduler and
> with the version sent out for 2.5.53.  Results were similar:
>
> Kernbench:
>                         Elapsed       User     System        CPU
>              sched54    29.112s   283.888s     82.84s    1259.4%
>           oldsched54    29.436s   286.942s    82.722s    1256.2%
>
> sched54 = linux 2.5.54 with the 2.5.53 version of the NUMA scheduler
> oldsched54 = linux 2.5.54 with an earlier version of the NUMA scheduler
>
> The numbers for the new version are actually a touch better, but
> close enough to be within a reasonable margin of error.
>
> I'll post numbers against stock 2.5.54 and include schedbench, tomorrow.
>
>                Michael

