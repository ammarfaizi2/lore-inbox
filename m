Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSFOVOO>; Sat, 15 Jun 2002 17:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSFOVON>; Sat, 15 Jun 2002 17:14:13 -0400
Received: from holomorphy.com ([66.224.33.161]:23723 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315547AbSFOVON>;
	Sat, 15 Jun 2002 17:14:13 -0400
Date: Sat, 15 Jun 2002 14:13:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Amit Nadgar <vangough_spinlock@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing the struct task_struct using a pid
Message-ID: <20020615211346.GM22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amit Nadgar <vangough_spinlock@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020615210620.38592.qmail@web14401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 02:06:20PM -0700, Amit Nadgar wrote:
>    I am writing a kernel module where I am trying to
> access the task_structs. Now I have tried this using
> various mathods.
>    1) Using the pidhash array.
>       Here when I do a insmod I get a unresolved symbol.

EXPORT_SYMBOL(pidhash) or something. Make sure you included sched.h

On Sat, Jun 15, 2002 at 02:06:20PM -0700, Amit Nadgar wrote:
>    2) Directly accessing the location of pidhash as seen in System.map.
>       Here when the pidhash_fn hashes the supplied pid the particular
>	location into which it indexes in NULL.

How early are you trying to do this?

On Sat, Jun 15, 2002 at 02:06:20PM -0700, Amit Nadgar wrote:
>   3) Starting from the init_task.
>      here the next task after the init task is found to be NULL.

Don't do that.

On Sat, Jun 15, 2002 at 02:06:20PM -0700, Amit Nadgar wrote:
>	Could some one help me in this matter.

I'm afraid there's only so much help that can be given. Some effort may
be required on your part to make this work. Help with basic concepts
and Linux conventions is more likely to be found on irc.openprojects.net
#kernelnewbies or the kernelnewbies@nl.linux.org mailing list.


Cheers,
Bill
