Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132150AbRCVTFR>; Thu, 22 Mar 2001 14:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRCVTFH>; Thu, 22 Mar 2001 14:05:07 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:31248 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132150AbRCVTEv>;
	Thu, 22 Mar 2001 14:04:51 -0500
Message-ID: <20010322200408.A5404@win.tue.nl>
Date: Thu, 22 Mar 2001 20:04:08 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Patrick O'Rourke" <orourke@missioncriticallinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl> <Pine.LNX.4.21.0103221200410.21415-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0103221200410.21415-100000@imladris.rielhome.conectiva>; from Rik van Riel on Thu, Mar 22, 2001 at 12:01:43PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 22, 2001 at 12:01:43PM -0300, Rik van Riel wrote:

> > Last month I had a computer algebra process running for a week.
> > Killed. But this computation was the only task this machine had.
> > Its sole reason of existence.
> > Too bad - zero information out of a week's computation.
> > 
> > Clearly, Linux cannot be reliable if any process can be killed
> > at any moment. I am not happy at all with my recent experiences.
> 
> Note that the OOM killer in 2.4 won't kick in until your machine
> is out of both memory and swap, see mm/oom_kill.c::out_of_memory().

Nevertheless, this process does malloc and malloc returns the requested
memory. If a malloc fails the computer algebra process has the choice
between various alternatives. Present a prompt, so that the user can
examine variables and intermediate results, or request a dump to disk
of the status of the computation. Or choose an alternative algorithm,
at some other point of the space-time tradeoff curve.
But no error return from malloc - just "Killed". Ach.

Andries
