Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbSIWDpj>; Sun, 22 Sep 2002 23:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIWDpi>; Sun, 22 Sep 2002 23:45:38 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:50054 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S263979AbSIWDph>;
	Sun, 22 Sep 2002 23:45:37 -0400
Message-ID: <1032753047.3d8e8f973e17d@kolivas.net>
Date: Mon, 23 Sep 2002 13:50:47 +1000
From: Con Kolivas <conman@kolivas.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
References: <1032750261.3d8e84b5486a9@kolivas.net> <3D8E8D7F.810EF57F@digeo.com> <20020923034626.GA28612@nevyn.them.org>
In-Reply-To: <20020923034626.GA28612@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Jacobowitz <dan@debian.org>:

> On Sun, Sep 22, 2002 at 08:41:51PM -0700, Andrew Morton wrote:
> > Con Kolivas wrote:
> > > 
> > > I performed contest benchmarks on kernel 2.5.38 when the kernel is
> compiled with
> > > gcc3.2 to gcc2.95.3
> > > 
> > > warning: The following benchmarks may be disturbing to some viewers:
> > > 
> > > No Load:
> > > Kernel                  Time            CPU
> > > 2.5.38                  68.25           99%
> > > 2.5.38-gcc32            103.03          99%
> > > 
> > 
> > Try gcc-2.91.66.  It might break the 45 second mark.
> > 
> > > IO Full Load:
> > > Kernel                  Time            CPU
> > > 2.5.38                  170.21          42%
> > > 2.5.38-gcc32            1405.25         8%
> > 
> > The streaming write is stalling gcc's read for long enough for gcc's
> > working set to be evicted.  And the working set cannot be reestablished
> > because the streaming write prevents it.  Meltdown.
> > 
> > I have fixed this.  Hang around.
> 
> That sounds like a slowdown in _running_ GCC... The worrisome part of
> Con's post is that he was talking about which compiler he'd built the
> kernel with.  Right?

Correct. contest was run with gcc2.95.3 only. The kernels were compiled with
2.95.3 and 3.2 respectively.

Con.
