Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270009AbRH1AbZ>; Mon, 27 Aug 2001 20:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRH1AbP>; Mon, 27 Aug 2001 20:31:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44040 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269971AbRH1AbD>; Mon, 27 Aug 2001 20:31:03 -0400
Date: Mon, 27 Aug 2001 20:03:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM: Bad swap entry 0044cb00
In-Reply-To: <20010828012308.A36433@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.21.0108272001080.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, John Levon wrote:

> On Mon, Aug 27, 2001 at 07:46:56PM -0300, Marcelo Tosatti wrote:
> 
> > > I upgraded my kernel from 2.4.8ac10 to 2.4.9ac2 some hours ago and I found
> > > the following message in my syslog file (I've never seen something like
> > > this before):
> > > 
> > > Aug 27 22:40:46 r063144 kernel: VM: Bad swap entry 0044cb00
> > > 
> > > 
> > > What does this mean (my machine seems to run fine)?
> > 
> > Did you turned any swap file/partition off? (with swapoff) 
> 
> fwiw, this seems to be a common characteristic of hardware problems with
> 2.4 kernels. I've had bad RAM (discovered by memtest86) which was producing
> this error without any swapoff. Once it only occurred after an entire night
> of kernel compiles (memtest86 found it easily however)

It may well be a memory problem (Andrian, can you run memtest86 so we can
confirm that). 

OTOH, Hugh Dickins has changed the swapin code lately to fix similar
problems and there is one user still reporting SIGSEGV's under stress
testing. 

