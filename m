Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJPUyi>; Wed, 16 Oct 2002 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSJPUyi>; Wed, 16 Oct 2002 16:54:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6149 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261388AbSJPUyh>; Wed, 16 Oct 2002 16:54:37 -0400
Date: Wed, 16 Oct 2002 17:00:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: "'David S. Miller'" <davem@redhat.com>, robm@fastmail.fm,
       hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org,
       jhoward@fastmail.fm
Subject: RE: Strange load spikes on 2.4.19 kernel
In-Reply-To: <000c01c2728d$263c0ca0$7443f4d1@joe>
Message-ID: <Pine.LNX.3.96.1021016165637.12145B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Joseph D. Wagner wrote:

> Now wait a minute!  Allocating blocks and inodes is an integral part of
> a write.  Oh sure the actual writing of file data is SMP, but that
> process is bottlenecked by single threaded allocation of blocks and
> inodes.  Perhaps I could phrase what I said to be more technically
> accurate by saying, "Writing makes such poor use of multi-threading on
> SMP that in terms of performance it's as if it was single threaded."

People should note that the reason this hasn't been addressed to date is
that the disk is so many orders of magnitude slower than CPU that the
practical effect of the "bottleneck" is below the noise with most
hardware.

So you're not wrong, but you seem to be making it more of an issue than
the actual impact seems to justify. I bet you can measure it, or even
config a system where it matters, but in most cases it doesn't.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

