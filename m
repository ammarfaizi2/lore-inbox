Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUDDOdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDDOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:33:44 -0400
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:60534 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S262418AbUDDOdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:33:41 -0400
Message-ID: <006101c41a53$1913eb00$b07aa8c0@VALUED65BAD02C>
From: "Amit" <khandelw@cs.fsu.edu>
To: <karim@opersys.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1080849830.91ac1e3f85274@system.cs.fsu.edu>	<406C79E4.1060700@opersys.com> <1081012426.5c22c66499b13@system.cs.fsu.edu>	<406F21CB.8070908@opersys.com> <1081026049.f64d5288b5aaa@system.cs.fsu.edu> <406F2851.6050304@opersys.com> <003b01c419d0$67e59e50$af7aa8c0@VALUED65BAD02C> <406F476D.8050002@opersys.com> <005901c419d5$5ecd7c70$af7aa8c0@VALUED65BAD02C> <406F4FCD.7020506@opersys.com>
Subject: Re: kernel 2.4.16
Date: Sun, 4 Apr 2004 10:42:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Karim,
    We have got LTT running for 2.6.3 and 2.419. We collected some traces
for both 2.4.19 and 2.6.3. The gui looks really cool. However, just one
thing with 2.6.3 when I feed in the trace file and the proc file it dumps
core.

I execute the following command :-
- tracedaemon -ts10 ./out.trace ./out.proc
to get the trace and the proc file.

Thanks,
Amit Khandelwal





----- Original Message ----- 
From: "Karim Yaghmour" <karim@opersys.com>
To: "Amit" <khandelw@cs.fsu.edu>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, April 03, 2004 7:59 PM
Subject: Re: kernel 2.4.16


>
> Amit wrote:
> >    The installation has gone through smoothly and I have managed to get
an
> > linux-2.6.3 up and running with LTT.
> > I checked the documentation and it says that I need to do an insmod on
the
> > tracer but I have compiled it as a part of the kernel. Now the
documentation
> > says that I should execute the createdev.sh to create the devices. When
I
> > execute that I get errors related to tracer. When I try to execute the
> > tracedaemon I get that relayfs is not mounted. Can you please tell me
how to
> > go about doing the first part. After doing all this I want to run some
test
> > cases and see how does LTT generate traces. Later on I would also like
to
> > add rtai to this and see the traces from that too.
>
> The documentation is out of date. Basically, the createdev.sh script isn't
> needed anymore because of relayfs. You need to mount relayfs to use LTT.
> See the classic dox on filesystem mounting for this kind of thing. It's
> going to be something like:
> # mount -t relayfs nodev /mnt/relay
>
> There's no insmod for LTT. It isn't a device driver module, following LKML
> recommendations.
>
> As for RTAI, there's currently no RTAI support in relayfs. If you want to
have
> RTAI tracing, then you'd have to fall back on earlier stable versions of
LTT.
>
> > PS. I would like to write down a small howto on this and pass it on to
you
> > so that newbies like me can have a good ref. Thanks for the help.
>
> Sure.
>
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
>


