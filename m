Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291466AbSBHIWg>; Fri, 8 Feb 2002 03:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSBHIW0>; Fri, 8 Feb 2002 03:22:26 -0500
Received: from [64.42.30.110] ([64.42.30.110]:15880 "HELO mail.clouddancer.com")
	by vger.kernel.org with SMTP id <S291466AbSBHIWX>;
	Fri, 8 Feb 2002 03:22:23 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20020208082137.56E2C7843A@phoenix.clouddancer.com>
Date: Fri,  8 Feb 2002 00:21:37 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: Re: New scheduler in 2.4. series?
Reply-to: klink@clouddancer.com


On boot, my rc.local script renices the SQL server to -20.  Later I
usually run a set of perl scripts that make thousands of SQL fetches
for 20 minutes.  I have also kicked off a complete kernel rebuild,
using make -j, to see what happens.  My X window manager is fvwm with
13 virtual desktops, and under this load with kernel 2.4.17 ( SMP, the
K2 patch and 512M of RAM ), for a short time ~<2 minutes, I have
delays in switching virtual desktops to the other tasks that are
active.  Afterwards the virtual desktop switching is about as smooth
as with an unloaded system.  'Top' reports loads of over 50 and over
500 processes active.  Since I remember starting with kernel 1.1.41
and 8M of RAM, this sort of responsiveness leaves a smile on my face.

Yesterday I had xmms running, and heard gaps in the music.  I dropped
back to 2.4.10-ac12 (I had a lot of time running that kernel) for
comparison.  Several processes had been killed within minutes...and
the gaps in xmms were far worse while it was still running.

>From my perspective, this line of development is simply astonishing.
A small pause is a very small price to pay, considering the
alternatives boiled down to 'wait until the machine is less busy'.

THANKS!

------------------------------------------------------------------
On Wed, 6 Feb 2002, Kristian wrote:

> -K2 behaves much better as -J2 did. The system gets continuously
> responsive again. But with nicelevel -5 at the beginning of each 'tar`
> the systems stalls for 2 or 3 seconds.

yes, it takes 2-3 seconds for the system to notice that the 'tar'
process started from your interactive shell is in fact a 'CPU
hog'. The system was honoring root's request for CPU time.

this should not happen if you start it at nice -2, which should still
give 'tar' enough of an advantage.

        Ingo
