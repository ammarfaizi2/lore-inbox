Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbRFHXqT>; Fri, 8 Jun 2001 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264408AbRFHXqJ>; Fri, 8 Jun 2001 19:46:09 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:57082 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264407AbRFHXqB>; Fri, 8 Jun 2001 19:46:01 -0400
Message-Id: <l0313032bb7471092da13@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0106081701300.2422-100000@freak.distro.conectiva>
In-Reply-To: <15137.15472.264539.290588@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 9 Jun 2001 00:44:13 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        John Stoffel <stoffel@casc.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Tobias Ringstrom <tori@unhappy.mine.nu>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Re-entering discussion after too long a day and a long sleep... ]

>> There is the problem in terms of some people want pure interactive
>> performance, while others are looking for throughput over all else,
>> but those are both extremes of the spectrum.  Though I suspect
>> raw throughput is the less wanted (in terms of numbers of systems)
>> than keeping interactive response good during VM pressure.
>
>And this raises a very very important point: raw throughtput wins
>enterprise-like benchmarks, and the enterprise people are the ones who pay
>most of hackers here. (including me and Rik)

Very true.  As well as the fact that interactivity is much harder to
measure.  The question is, what is interactivity (from the kernel's
perspective)?  It usually means small(ish) processes with intermittent
working-set and CPU requirements.  These types of process can safely be
swapped out when not immediately in use, but the kernel has to be able to
page them in quite quickly when needed.  Doing that under heavy load is
very non-trivial.

It can also mean multimedia applications with a continuous (maybe small)
working set, a continuous but not 100% CPU usage, and the special property
that the user WILL notice if this process gets swapped out even briefly.
mpg123 and XMMS fall into this category, and I sometimes tried running
these alongside my compilation tests to see how they fared.  I think I had
it going fairly well towards the end, with mpg123 stuttering relatively
rarely and briefly while VM load was high.

On the subject of Mike Galbraith's kernel compilation test, how much
physical RAM does he have for his machine, what type of CPU is it, and what
(approximate) type of device does he use for swap?  I'll see if I can
partially duplicate his results at this end.  So far all my tests have been
done with a fast CPU - perhaps I should try the P166/MMX or even try
loading linux-pmac onto my 8100.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


