Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272306AbRHXTri>; Fri, 24 Aug 2001 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272305AbRHXTr2>; Fri, 24 Aug 2001 15:47:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8976 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272314AbRHXTrN>; Fri, 24 Aug 2001 15:47:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: What version of the kernel fixes these VM issues?
Date: Fri, 24 Aug 2001 21:53:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Anwar P <anwarp@mail.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108241354520.25240-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0108241354520.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824194724Z16096-32383+1210@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 08:14 pm, Nicolas Pitre wrote:
> On Fri, 24 Aug 2001, Daniel Phillips wrote:

> > Please try 2.4.9 and 2.4.8-ac10.  If the system slows down, look in your logs
> > and see if there are any "allocation failed" messages.  Use top or do watch
> > cat /proc/meminfo to be sure your system isn't going into swap, and please
> > let us know what happens.
> 
> I have a totally different setup but I can reproduce the same behavior on
> the system I have here:
> 
> ARM board with 32 MB RAM, no flash, NFS root.
> The kernel is based on 2.4.8-ac9 plus some small VM fixes from -ac10.

What happens with 2.4.9?

> My test consist in compiling gcc 3.0 while some MP3s are continously playing
> in the background.  The gcc build goes pretty far along until both the mp3
> player and the gcc build completely jam.  Oh maybe not completely as I get
> about 100ms of audio playing every 10 secs.  bash starts echoing what I type
> one char per approx 5 sec.  The only thing that still works fine is the
> magic sysrq that clearly shows that the CPU is spinning in the VM code. NFS
> trafic is also going on full bandwidth but no progress ever happens in user
> space.
> 
> My console is on a serial port so if someone can send me a patch with
> whatever printks to trace what's happening in real time I'll be glad to
> provide the trace file.  Reaching the jam state takes about 5 minutes so
> it's not hard to reproduce.

Try:

	watch cat /proc/meminfo

--
Daniel
