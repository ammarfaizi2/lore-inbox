Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJYTG3>; Thu, 25 Oct 2001 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJYTGT>; Thu, 25 Oct 2001 15:06:19 -0400
Received: from opus.cs.columbia.edu ([128.59.20.100]:56313 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S275990AbRJYTGO> convert rfc822-to-8bit; Thu, 25 Oct 2001 15:06:14 -0400
Subject: Re: Linux Scheduler and Compilation
From: Shaya Potter <spotter@cs.columbia.edu>
To: =?ISO-8859-1?Q?Jos=E9?= Luis Domingo =?ISO-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011025203743.B504@dardhal.mired.net>
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424> 
	<20011025203743.B504@dardhal.mired.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99 (Preview Release)
Date: 25 Oct 2001 15:06:49 -0400
Message-Id: <1004036810.1770.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 16:37, José Luis Domingo López wrote:
> On Thursday, 25 October 2001, at 18:20:25 +0300,
> Omer Sever wrote:
> 
> >      I have a project on Linux CPU Scheduler to make it Fair Share
> > Scheduler.I will make some changes on some files such as sched.c vs...I will
> > want to see the effect ot the change but recompilation of the kernel takes
> > about half an hour on my machine.How can I minimize this time?Which part
> > should I necessarily include in my config file for the kernel to minimize
> > it?
> > 
> make is your friend: it will only recompile those files that changed from
> the last compilation. If you modify some #includes in the code, I believe
> you will have to also run "make dep" before, to get dependencies right.

Except, as I discovered recently in playing around with the scheduler,
if you modify sched.h, you basically have to recompile the entire
kernel, as it seems everything depends on it.

On that note, why is add_to_runqueue() in sched.c and
del_from_runqueue() in sched.h?  del_from_runqueue being the only func I
was modifying in sched.h (really annoying have to recompile an entire
kernel multiple times in a vmware vm, albiet thats not a good reason to
move it, I'm just wondering why they are split in 2 different files)

thanks,

shaya 

