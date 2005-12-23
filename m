Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbVLWTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbVLWTFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbVLWTFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:05:32 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:57812 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030605AbVLWTFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:05:32 -0500
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
From: Lee Revell <rlrevell@joe-job.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43ABC8B2.7020904@gmail.com>
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU>
	 <43ABC8B2.7020904@gmail.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 14:08:58 -0500
Message-Id: <1135364939.22177.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 11:51 +0200, Alon Bar-Lev wrote:
> David Wagner wrote:
> > In article <43AACA82.5050305@gmail.com> you write:
> > 
> >>I am writing a provider that uses pthreads. The main program 
> >>does not aware that the provider is using threads and it is 
> >>not multithreaded.
> >>
> >>After initialization the program setuid to nobody, the 
> >>problem is that my threads remains in root id.
> > 
> > 
> > Mixing threads and setuid programs seems like a really bad idea.
> > This is especially true if you have to ask about it -- which means
> > that you don't know enough to write such a program safely (please
> > don't take offense).
> > 
> 
> I know that!
> And I am aware of the (Linux implementation) implications...
> 
> I don't think you read my question in deep...
> I offer a provider (Shared library), and I must deal with 
> this edge condition where the main program setuid.
> 
> In Linux every thread is a process so only the main thread 
> is setuided.
> 
> I need to catch this even in my shared library and setuid my 
> threads as well, since Linux pthreads implementation does 
> not take care of this.
> 
> Since I am not writing the main program and since I cannot 
> force the main programmer to behave any differently, I must 
> handle this internally.
> 
> Do you know a way to be notified when the process setuid?

Why on earth would you use LinuxThreads rather than NPTL?  LinuxThreads
is obsolete and was never remotely POSIX compliant.

Lee

