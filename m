Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131304AbRCWRW7>; Fri, 23 Mar 2001 12:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRCWRWt>; Fri, 23 Mar 2001 12:22:49 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:39844 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131297AbRCWRWh>; Fri, 23 Mar 2001 12:22:37 -0500
Date: Fri, 23 Mar 2001 17:26:22 +0000 (GMT)
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Guest section DW <dwguest@win.tue.nl>
cc: Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Guest section DW wrote:
> On Wed, Mar 21, 2001 at 08:48:54PM -0300, Rik van Riel wrote:
> > On Wed, 21 Mar 2001, Patrick O'Rourke wrote:
>
> > > Since the system will panic if the init process is chosen by
> > > the OOM killer, the following patch prevents select_bad_process()
> > > from picking init.
>
> There is a dozen other processes that must not be killed.
> Init is just a random example.

That depends what you mean by "must not". If it's your missile guidance
system, aircraft autopilot or life support system, the system must not run
out of memory in the first place. If the system breaks down badly, killing
init and thus panicking (hence rebooting, if the system is set up that
way) seems the best approach.

> > One question ... has the OOM killer ever selected init on
> > anybody's system ?
>
> Last week I installed SuSE 7.1 somewhere.
> During the install: "VM: killing process rpm",
> leaving the installer rather confused.
> (An empty machine, 256MB, 144MB swap, I think 2.2.18.)

If SuSE's install program needs more than a quarter Gb of RAM, you need a
better distro.

> Last month I had a computer algebra process running for a week.
> Killed. But this computation was the only task this machine had.
> Its sole reason of existence.
> Too bad - zero information out of a week's computation.

A computation your system was incapable of performing. OK, it's a shame it
took you a week to find this out, but the computation had to die: if the
only process running cannot run, it has to die!

> (I think 2.4.0.)
>
> Clearly, Linux cannot be reliable if any process can be killed
> at any moment.

What on earth did you expect to happen when the process exceeded the
machine's capabilities? Using more than all the resources fails. There
isn't an alternative.


James.

