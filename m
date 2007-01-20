Return-Path: <linux-kernel-owner+w=401wt.eu-S965095AbXATBTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXATBTg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXATBTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:19:36 -0500
Received: from smtp.ono.com ([62.42.230.12]:45829 "EHLO resmaa01.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965095AbXATBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:19:35 -0500
Date: Sat, 20 Jan 2007 02:18:45 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Brian McGrew <brian@visionpro.com>, linux-kernel@vger.kernel.org,
       fedora-users@rdhat.com
Subject: Re: Threading...
Message-ID: <20070120021845.02b4f4fc@werewolf-wl>
In-Reply-To: <1169232941.3055.555.camel@laptopd505.fenrus.org>
References: <C1D65141.16E37%brian@visionpro.com>
	<1169232941.3055.555.camel@laptopd505.fenrus.org>
X-Mailer: Claws Mail 2.7.1cvs34 (GTK+ 2.10.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007 19:55:41 +0100, Arjan van de Ven <arjan@infradead.org> wrote:

> On Fri, 2007-01-19 at 10:43 -0800, Brian McGrew wrote:
> > I have a very interesting question about something that we're seeing
> > happening with threading between Fedora Core 3 and Fedora Core 5.  Running
> > on Dell PowerEdge 1800 Hardware with a Xeon processor with hyper-threading
> > turned on.  Both systems are using a 2.6.16.16 kernel (MVP al la special).
> > 
> > We have a multithreaded application that starts two worker threads.  On
> > Fedora Core 3 both of these we use getpid() to get the PID of the thread and
> > then use set_afinity to assign each thread to it's own CPU.  Both threads
> > run almost symmetrically even on their given CPU watching the system
> > monitor.
> 
> this is odd; even in FC3 getpid() is supposed to return the process ID
> not the thread ID
> 
> > What am I missing?  What do I need to do in FC5 or the kernel or the
> > threading library to get my threads to run in symmetric parallel again???
> 

One thing to try. In linux, pthread_setconcurrency never did nothing
(it _really_ did in IRIX...). Can you try that ? Perhaps FC5 has implemented
some kind of scheduling policy like that on irix (everything stays on the
same CPU until it starts to suck cycles, unless you use setconcurrency).

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.19-jam04 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.2mdv2007.1)) #0 SMP PREEMPT
