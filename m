Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUG0DIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUG0DIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUG0DIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:08:09 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:53253 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266199AbUG0DH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:07:57 -0400
Date: Tue, 27 Jul 2004 13:02:32 +1000 (EST)
From: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: Con Kolivas <kernel@kolivas.org>
cc: Clemens Schwaighofer <cs@tequila.co.jp>, Andrew Morton <akpm@osdl.org>,
       Joel.Becker@oracle.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Autotune swappiness01
In-Reply-To: <cone.1090896213.276247.20693.502@pc.kolivas.org>
Message-ID: <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>
 <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org>
 <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org>
 <cone.1090882721.156452.20693.502@pc.kolivas.org> <4105A761.9090905@tequila.co.jp>
 <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp>
 <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au>
 <cone.1090896213.276247.20693.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Con Kolivas wrote:

> Tim Connors writes:
>
> > Clemens Schwaighofer <cs@tequila.co.jp> said on Tue, 27 Jul 2004 10:17:16 +0900:
> >>
> >> Andrew Morton wrote:
> >> | It may appear to be better, but you now have 100, maybe 200 megabytes less
> >> | pagecache available across the entire working day.
> >>
> >> which might slow down overall working speed? or responsness of programs?
> >
> > Depends on what you do. Do you compile kernels regularly? In
> > particular, do you have to wait for them, or do you just let them sit
> > in the background, and come back to them when you rememeber, since
> > you've been busy doing real work for the past 5 hours? If you wait,
> > then I guess you want high swapiness.
>
> Well I'm tired of this discussion which comes up every month or so and I
> brought it up! Clearly my patch is not considered adequate so I promise
> never to bring it up again.

I am not trying to say anything bad about your work - I am trying to
caution Andrew that not everyone cares so much that they lose 200 megs of
pagecache. It doesn't affect everyone equally - I'm just trying to put the
voice of those of us who care more about responsiveness than throughput,
if I may borrow the argument from upthread.

I often fear that a lot of benchmarking is done one-sided, and does not
reflect the usage patterns of a typical Linux user.

Then there's the relative importance of subjective "feel", vs hard
numbers. Maybe some people prefer that their system feels nicer, even if
it doesn't compile kernels so fast. And I think this decision is best left
to at least one of those knobs (hey, all you know, people might even
adjust the knob in a crontab).

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Usage: fortune -P [-f] -a [xsz] Q: file [rKe9] -v6[+] file1 ...
