Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263221AbSIWDlm>; Sun, 22 Sep 2002 23:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263576AbSIWDlm>; Sun, 22 Sep 2002 23:41:42 -0400
Received: from crack.them.org ([65.125.64.184]:8463 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263221AbSIWDll>;
	Sun, 22 Sep 2002 23:41:41 -0400
Date: Sun, 22 Sep 2002 23:46:26 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
Message-ID: <20020923034626.GA28612@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
References: <1032750261.3d8e84b5486a9@kolivas.net> <3D8E8D7F.810EF57F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8E8D7F.810EF57F@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 08:41:51PM -0700, Andrew Morton wrote:
> Con Kolivas wrote:
> > 
> > I performed contest benchmarks on kernel 2.5.38 when the kernel is compiled with
> > gcc3.2 to gcc2.95.3
> > 
> > warning: The following benchmarks may be disturbing to some viewers:
> > 
> > No Load:
> > Kernel                  Time            CPU
> > 2.5.38                  68.25           99%
> > 2.5.38-gcc32            103.03          99%
> > 
> 
> Try gcc-2.91.66.  It might break the 45 second mark.
> 
> > IO Full Load:
> > Kernel                  Time            CPU
> > 2.5.38                  170.21          42%
> > 2.5.38-gcc32            1405.25         8%
> 
> The streaming write is stalling gcc's read for long enough for gcc's
> working set to be evicted.  And the working set cannot be reestablished
> because the streaming write prevents it.  Meltdown.
> 
> I have fixed this.  Hang around.

That sounds like a slowdown in _running_ GCC... The worrisome part of
Con's post is that he was talking about which compiler he'd built the
kernel with.  Right?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
