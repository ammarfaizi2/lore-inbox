Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSFLGXX>; Wed, 12 Jun 2002 02:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSFLGXW>; Wed, 12 Jun 2002 02:23:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40403 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317640AbSFLGXV>;
	Wed, 12 Jun 2002 02:23:21 -0400
Date: Wed, 12 Jun 2002 08:20:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Anjali Kulkarni <anjali@indranetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler problems
In-Reply-To: <200206120520.WAA11199@eagle.he.net>
Message-ID: <Pine.LNX.4.44.0206120809250.4043-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jun 2002, Anjali Kulkarni wrote:

> I am getting a problem in the scheduler() function....
> 
> I am running an in-kernel proxy on linux 2.2.16 and I get a problem in 
> sched.c at line 384. [...]

(given that the current 2.2 kernel is 2.2.21, the first thing would be to
test it there too.)

> [...] It is due to the fact that the schedule() function does not find
> the 'current' process in the runqueue. [...]

a crash in line 384 means that the runqueue got corrupted by something,
most likely caused by buggy kernel code outside of the scheduler.

> Can anyone tell me what's happening here? My kernel module is no way the
> cause of any of this. [...]

does it happen if you do not run your kernel module after bootup, ever?

	Ingo

