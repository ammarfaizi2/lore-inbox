Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264930AbSKEGGx>; Tue, 5 Nov 2002 01:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSKEGGw>; Tue, 5 Nov 2002 01:06:52 -0500
Received: from codepoet.org ([166.70.99.138]:50088 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264930AbSKEGGi>;
	Tue, 5 Nov 2002 01:06:38 -0500
Date: Mon, 4 Nov 2002 23:13:17 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Werner Almesberger <wa@almesberger.net>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105061316.GA7045@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Werner Almesberger <wa@almesberger.net>, jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021105044216.GA4545@codepoet.org> <3838354491.1036446246@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3838354491.1036446246@[10.10.2.3]>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 04, 2002 at 09:44:07PM -0800, Martin J. Bligh wrote:
> > Hehe.  You just reinvented my old /dev/ps driver.  :)
> 
> Indeed, sounds much more like a /dev thing than a /proc thing
> at this point ;-)
> 
> > http://www.busybox.net/cgi-bin/cvsweb/busybox/examples/kernel-patches/devps.patch.9_25_2000?rev=1.2&content-type=text/vnd.viewcvs-markup
> > 
> > This is what Linus has to say on the subject:
> > 
> > ... If the problem is that /proc
> >     is too large, then the right solution is to just clean up
> >     /proc.  Which is getting done.  And yes, /proc will be larger
> >     than /dev/ps, but I still find that preferable to having two
> >     incompatible ways to do the same thing.
> 
> Ummm ... how do we make /proc smaller than 1 file to open per PID?
> It's pretty easy to get it down that far. But it still sucks.
> 
> >     I do dislike /dev/ps mightily.
> 
> Well it can't be any worse than the current crap. At least it'd 
> stand a chance in hell of scaling a little bit. So I took a very 
> quick look ... what syscalls are you reduced to per pid, one ioctl 
> and one read?

As I implemented it, it was one ioctl per pid...  Of course 
it could be easily modified to be one syscall, one read from
the /dev/ps char device, or similar...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
