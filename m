Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263576AbSIWDmg>; Sun, 22 Sep 2002 23:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSIWDmg>; Sun, 22 Sep 2002 23:42:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39944
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263576AbSIWDme>; Sun, 22 Sep 2002 23:42:34 -0400
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3D8E8D7F.810EF57F@digeo.com>
References: <1032750261.3d8e84b5486a9@kolivas.net> 
	<3D8E8D7F.810EF57F@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 23:47:46 -0400
Message-Id: <1032752867.962.1012.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 23:41, Andrew Morton wrote:

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

Ehh, I was under the impression he was benchmarking kernels compiled
WITH these compilers, using contest?

Your post seems to imply he was using the compilers as the benchmark. 
If so, I retract my previous post - I know gcc 3.x is slow as puke.  I
think, however, he is comparing the resulting kernels, in which case
there is a serious issue at hand...

	Robert Love

