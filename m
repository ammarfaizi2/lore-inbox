Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281337AbRKEVDC>; Mon, 5 Nov 2001 16:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281336AbRKEVCw>; Mon, 5 Nov 2001 16:02:52 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:42962 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281335AbRKEVCm>; Mon, 5 Nov 2001 16:02:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Rik van Riel <riel@conectiva.com.br>, Ben Greear <greearb@candelatech.com>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Mon, 5 Nov 2001 22:03:05 +0100
X-Mailer: KMail [version 1.3.1]
Cc: <dalecki@evision.ag>, Stephen Satchell <satch@concentric.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160qqc-1ClvWqC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 19:40, Rik van Riel wrote:
> I think you've hit the core of the problem. There is no magical
> bullet which will stop badly written userland programs from
> breaking, but the kernel developers should have the courtesy
> of providing documentation for the /proc files so the writers
> of userland programs can have an idea what to expect.

I think the core insight is that if the kernel continues to have dozens of 
"human-readable" file formats in /proc, each should to be documented using a 
BNF description that can guarantee that the format is still valid in the 
future, even if there is the need to add additional fields. 
The result of this is, of course, that it may be very hard to write 
shell scripts that won't break sooner or later and that accessing the data in 
C is much more work than a simple scanf. 

bye...
