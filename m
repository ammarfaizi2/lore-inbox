Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277985AbRJRTNL>; Thu, 18 Oct 2001 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277986AbRJRTNC>; Thu, 18 Oct 2001 15:13:02 -0400
Received: from pc2-redb4-0-cust130.bre.cable.ntl.com ([213.107.133.130]:507
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S277985AbRJRTMu>; Thu, 18 Oct 2001 15:12:50 -0400
Date: Thu, 18 Oct 2001 20:13:21 +0100
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.x process limits (NR_TASKS)?
Message-ID: <20011018201321.B3187@itsolve.co.uk>
In-Reply-To: <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org> <3BCF27D5.CE4C53DE@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BCF27D5.CE4C53DE@didntduck.org>; from bgerst@didntduck.org on Thu, Oct 18, 2001 at 03:04:53PM -0400
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:04:53PM -0400, Brian Gerst wrote:

> Gregory Ade wrote:
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > We're running into what appears to be a 256-process-per-user limit on one
> > of our webservers, due to the number of processes running as a specific
> > user for our application.  I'd like to increase the process limit, and
> > *THINK* that to do so i need to increase NR_TASKS in
> > /usr/src/linux/include/linux/tasks.h.
> > 
> > Is this correct?  What other things do I need to watch out for when making
> > this modification?
> > 
> > Also, where can this limit be changed in 2.4.x?
> > 
> > Thanks ahead of time.
> > 
> 
> 2.2.x has a hard limit of 512 tasks on the x86 because it uses hardware
> task switching.  2.4.x allows an unlimited number of tasks, and is
> configurable via /proc/sys/kernel/threads-max and ulimit.

eh? why? The GDT can hold up to 2 ** 16 bytes (limit is 16-bit). Each entry is 8
bytes, that means that there are 8192 possible 'slots' in the GDT. Each process
has 2 entries, an LDT and a task struct entry. Why is the limit 512? couldn't it
be about 4000? (Some entries are needed for APM and other things...)

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
