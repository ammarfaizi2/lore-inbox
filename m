Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280041AbRKDXnZ>; Sun, 4 Nov 2001 18:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKDXnP>; Sun, 4 Nov 2001 18:43:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3487 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280051AbRKDXnE>;
	Sun, 4 Nov 2001 18:43:04 -0500
Date: Sun, 4 Nov 2001 18:42:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jakob =?koi8-r?q?=3Fstergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011104214229Z17052-23341+37@humbolt.nl.linux.org>
Message-ID: <Pine.GSO.4.21.0111041841480.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Daniel Phillips wrote:

> Doing 'top -d .1' eats 18% of a 1GHz cpu, which is abominable.  A kernel
> profile courtesy of sgi's kernprof shows that scanning pages does not move
> the needle, whereas sprintf does.  Notice that the biggest chunk of time

Huh?  Scanning pages is statm_pgd_range().  I'd say that it takes
seriously more than vsnprintf() - look at your own results.

