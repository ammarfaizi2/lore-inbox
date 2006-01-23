Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWAWUIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWAWUIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWAWUIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:08:34 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:50645 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964869AbWAWUIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:08:34 -0500
Date: Mon, 23 Jan 2006 21:09:18 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
 2.6.16-rc1-mm1
Message-ID: <20060123210918.54d4fc75@localhost>
In-Reply-To: <43D2BE83.1020200@bigpond.net.au>
References: <43D00887.6010409@bigpond.net.au>
	<20060121114616.4a906b4f@localhost>
	<43D2BE83.1020200@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006 10:06:43 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> > ---- spa_ebs: great! (as expected)
> > 
> > (sched_fooler)
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5418 paolo     34   0  2392  288  228 R 51.4  0.1   1:06.47 a.out
> >  5419 paolo     34   0  2392  288  228 R 43.7  0.1   0:54.60 a.out
> >  5448 paolo     11   0  4952 1468  372 D  3.0  0.3   0:00.12 dd
> > 
> > (transcode)
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5456 paolo     34   0  115m  18m 2432 R 51.9  3.7   0:23.34 transcode
> >  5470 paolo     12   0 51000 4472 1872 S  5.7  0.9   0:02.38 tcdecode
> >  5480 paolo     11   0  4948 1468  372 D  3.5  0.3   0:00.33 dd
> > 
> > Very good DD test performance in both cases.
> 
> Good.  How do you find the interactive responsiveness with this one?

It seems geneally good.

However I've noticed that priority of X fluctuate a lot for unknown
reasons...

When doing almost nothing it gets prio 6/7 but if I only move the
cursor a bit it jumps up to ~29. 

If I'm running glxgears (with diret rendering ON) the priority stay to
6/7 and moving the cursor I'm only able to get priority 8.

Under load X priority goes up and it suffers (cursor jumps a bit).

IOW: strangeness!

-- 
	Paolo Ornati
	Linux 2.6.16-rc1-plugsched on x86_64
