Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSHVWWg>; Thu, 22 Aug 2002 18:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSHVWWf>; Thu, 22 Aug 2002 18:22:35 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47092 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317582AbSHVWWe>; Thu, 22 Aug 2002 18:22:34 -0400
Subject: Re: MAX_PID changes in 2.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020822221106.GB5471@win.tue.nl>
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
	<1029799751.21212.0.camel@irongate.swansea.linux.org.uk>
	<20020820003346.GA4592@win.tue.nl>
	<1029804092.21242.18.camel@irongate.swansea.linux.org.uk> 
	<20020822221106.GB5471@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 23:27:46 +0100
Message-Id: <1030055266.3151.72.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 23:11, Andries Brouwer wrote:
> Ha, Alan - I am a bit slow, and you are a bit brief, but let us see.
> 
> I interpreted your "throughout" as "also outside IPC", and hence asked
> for clarification. For the moment, let me assume that we are just talking
> about SYSV IPC. (You were not thinking about uids instead of pids?)

I don't think there are any other pid ones. I've no idea what libc4 used
but I don't think I actually care . 

On the kernel side I found a ushort pid in coda, but I can't actually
easily tell if thats a process id or a coda thingy. We have some other
sloppy pid users but they all appear to be int (eg vt_kern.h)


> Remains the question whether that is bad.
> With large pid_t, the four variables msg_lspid, msg_lrpid, shm_cpid,
> shm_lpid will be truncated.
> 
> Who uses these? Nobody, as far as I can see from a recent collection
> of RPMs.

I have to admit I've not looked. I know of one (older AberMUD) which did
it for security tricks but thats hardly relevant to this nor a reason to
worry.

Alan

