Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTA1RnV>; Tue, 28 Jan 2003 12:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTA1RnV>; Tue, 28 Jan 2003 12:43:21 -0500
Received: from crack.them.org ([65.125.64.184]:42668 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267489AbTA1RnU>;
	Tue, 28 Jan 2003 12:43:20 -0500
Date: Tue, 28 Jan 2003 12:49:53 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
Message-ID: <20030128174953.GA23424@nevyn.them.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com> <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk> <20030128154541.GA7269@nevyn.them.org> <1043774823.9069.59.camel@phantasy> <20030128173949.GA23077@nevyn.them.org> <1043775771.9069.63.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043775771.9069.63.camel@phantasy>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:42:52PM -0500, Robert Love wrote:
> On Tue, 2003-01-28 at 12:39, Daniel Jacobowitz wrote:
> 
> > That wasn't my point.  All of the other threads have already terminated
> > without dumping core at tis point; I don't think it's possible for two
> > threads of a CLONE_THREAD application to both dump core.  See
> > fs/exec.c:coredump_wait.
> > 
> > Also, once one thread gets into do_coredump it clears mm->dumpable;
> > nothing else will dump core from that MM anyway.
> 
> Are you telling me only one thread per thread group can coredump,
> period?  So if two of them segfault (say concurrently on two different
> processors) only one will win the race to dump and the others will
> simply exit?

That's right.  The dump will include all the threads anyway, now.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
