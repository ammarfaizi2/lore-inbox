Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSIYXB6>; Wed, 25 Sep 2002 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbSIYXB6>; Wed, 25 Sep 2002 19:01:58 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:29877 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262139AbSIYXB5>;
	Wed, 25 Sep 2002 19:01:57 -0400
Message-ID: <1032995231.3d92419f7ef8b@kolivas.net>
Date: Thu, 26 Sep 2002 09:07:11 +1000
From: Con Kolivas <conman@kolivas.net>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] fork_load module tested for contest 
References: <200209252214.g8PMEQd06269@mail.osdl.org>
In-Reply-To: <200209252214.g8PMEQd06269@mail.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cliff White <cliffw@osdl.org>:
> > 
> > I've been trialling a new load module for the contest benchmark
> > (http://contest.kolivas.net) which simply forks a process that does
> nothing,
> > waits for it to die, then repeats. Here are the results I have obtained so
> far:
> > 
> > noload:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  72.90           99%             1.00
> > 2.4.19-ck7              71.55           100%            0.98
> > 2.5.38                  73.86           99%             1.01
> > 2.5.38-mm2              73.93           99%             1.01
> > 
> > fork_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  100.05          69%             1.37
> > 2.4.19-ck7              74.65           95%             1.02
> > 2.5.38                  77.35           95%             1.06
> > 2.5.38-mm2              76.99           95%             1.06
> > 
> > ck7 uses O1, preempt, low latency
> > Preempt=N for all other kernels
> > 
> > Clearly you can see the 2.5 kernels have a substantial lead over the
> current
> > stable kernel.
> > 
> > This load module is not part of the contest package yet. I could
> certainly
> > change it to fork n processes but I'm not really sure just how many n
> should be.
> 
> I think for OSDL/STP, it would be nice if n == number of CPU's, so maybe make
> 
> 'n' an arg?

Ok. I was more interested to know if maybe thousands of processes or something
like that would be interesting.

> When you say the process 'does nothing', what do you mean? It forks, then the
> 
> child does exit() ?

Yes the child forked execs nil.c which is basically return 0

Con
