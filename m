Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSEUQHL>; Tue, 21 May 2002 12:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSEUQHJ>; Tue, 21 May 2002 12:07:09 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:24709 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S315168AbSEUQHD>;
	Tue, 21 May 2002 12:07:03 -0400
Date: Tue, 21 May 2002 12:07:03 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lazy Newbie Question
In-Reply-To: <Pine.LNX.3.95.1020521114635.1232B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0205211159110.14445-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Richard B. Johnson wrote:

> On Tue, 21 May 2002, Calin A. Culianu wrote:
>
> >
> > Whats the best way to do the equivalent of a stat() on a char * pathname
> > from inside a kernel module?  Don't ask why I need to do this.. I know it
> > sounds evil but I just need to do it...  Basically I need to find out the
> > minor number of a device file.
> >
>
> No. You never "need to do it". Some user-mode task, somewhere, installs
> your module. That same task can open your device and via ioctl() tell
> it anything it needs to know.

Well I need to do it.  I know all about ioctls and the like,
thank-you-very-much.  I am writing code for COMEDI (have you heard of this
driver suite?) which uses a kernel-space API for Realtime Linux
(RTAI/RT-Linux).  So yes, I NEED TO DO IT!  :)

>
> A "file" is something the kernel handles on behalf of a task. That
> task has a context which, amongst other things, allows the kernel
> to assign file-descriptors. The kernel is not a task. It does not
> have a "context". Of course it can create one and it can steal one.
> These are the two methods used inside the kernel to handle "files".
>
> And, unless the kernel task "thread" is permanent, it's a dirty
> way of corrupting the kernel.
>

Yes, as meantioned above.. my thread is permanent.  It is a periodic
realtime priority thread.  However, the stuff that needs to determine
device minors is going to run at non-realtime priority.

At any rate.. please don't chastise me.  I am asking a simple question and
I wanted a straightforward answer.. I didn't expect to be flamed for it.

Have a nice day, Dick.

-Calin


