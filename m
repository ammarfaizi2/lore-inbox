Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279958AbRJ3OdU>; Tue, 30 Oct 2001 09:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279960AbRJ3OdL>; Tue, 30 Oct 2001 09:33:11 -0500
Received: from [209.195.52.30] ([209.195.52.30]:57377 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S279958AbRJ3Oc6>;
	Tue, 30 Oct 2001 09:32:58 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 30 Oct 2001 06:09:54 -0800 (PST)
Subject: Re: ipchains redirect failing in 2.4.5 (and 2.4.13)
In-Reply-To: <Pine.LNX.4.40.0110300535390.1329-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.40.0110300608240.1329-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

never mind, there was a http redirect comeing back that was causing this
test to fail.

back to the trying to find out why the machine slowed down so drasticly
:-(

David Lang

On Tue, 30 Oct 2001, David Lang wrote:

> Date: Tue, 30 Oct 2001 05:39:33 -0800 (PST)
> From: David Lang <david.lang@digitalinsight.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: ipchains redirect failing in 2.4.5 (and 2.4.13)
>
> I just confirmed that the problem still happens on 2.4.13.
>
> I also confirmed that I can suplicate the problem without multiple
> simultanious connections. if I do ab -n 50 (50 connections as fast as an
> athlon 1.2GHz can fire them off) I get the same failure. If the
> connections arrive at a sufficiantly slow rate the redirect works (no idea
> yet what that rate is yet)
>
> doing the test directly to the proxy port results in ~5
> connections/second. I don't see any reason that this should be enough to
> cause problems.
>
> David Lang
>
>
>  On Tue, 30 Oct 2001, David Lang wrote:
>
> > Date: Tue, 30 Oct 2001 05:04:35 -0800 (PST)
> > From: David Lang <david.lang@digitalinsight.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: ipchains redirect failing in 2.4.5
> >
> > I am attempting to track down a problem I have run into with 2.4.5
> >
> > I have a firewall that has proxies listening on ports 1433-1437. If I
> > connect to these proxies on these ports I have no problems, however if I
> > put in an ipchains rule to redirect port 1433 on a second IP address to
> > port 1436 (for example) and then hammer the box with ab -n 500 -s 20 the
> > first 20 or so connections get through and then the rest timeout. doing
> > repeated netstat -an on the firewall during this process shows an inital
> > burst of 15 connections that get established, a pause, and then a handfull
> > more get established, followed by those 20 connections being in TIME_WAIT
> >
> > again, connection to the same IP address on the real port the proxy is
> > listening on has no problems, it's only when going through the redirect
> > that it fails.
> >
> > any suggestions, tuning paramaters I missed, or tests I need to run to
> > track this down?
> >
> > David Lang
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
