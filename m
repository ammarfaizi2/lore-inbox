Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSKEEfq>; Mon, 4 Nov 2002 23:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSKEEfq>; Mon, 4 Nov 2002 23:35:46 -0500
Received: from codepoet.org ([166.70.99.138]:4004 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264891AbSKEEfp>;
	Mon, 4 Nov 2002 23:35:45 -0500
Date: Mon, 4 Nov 2002 21:42:16 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105044216.GA4545@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Werner Almesberger <wa@almesberger.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws> <1118170000.1036458859@flay> <20021105005745.E1407@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105005745.E1407@almesberger.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 05, 2002 at 12:57:45AM -0300, Werner Almesberger wrote:
> Martin J. Bligh wrote:
> > I had a very brief think about this at the weekend, seeing
> > if I could make a big melting pot /proc/psinfo file
> 
> You could take a more radical approach. Since the goal of such
> a psinfo file would be to accelerate access to information
> that's already available elsewhere, you can do away with many
> of the niceties of procfs, e.g.
> 
>  - no need to be human-readable (e.g. binary or hex dump may
>    make sense in this case)
>  - may use other operations than just open and read (e.g.

Hehe.  You just reinvented my old /dev/ps driver.  :)

http://www.busybox.net/cgi-bin/cvsweb/busybox/examples/kernel-patches/devps.patch.9_25_2000?rev=1.2&content-type=text/vnd.viewcvs-markup

This is what Linus has to say on the subject:

    I do dislike /dev/ps mightily. If the problem is that /proc
    is too large, then the right solution is to just clean up
    /proc.  Which is getting done.  And yes, /proc will be larger
    than /dev/ps, but I still find that preferable to having two
    incompatible ways to do the same thing.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
