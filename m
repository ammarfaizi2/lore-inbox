Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276018AbRJYTR0>; Thu, 25 Oct 2001 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRJYTRP>; Thu, 25 Oct 2001 15:17:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35461 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S276018AbRJYTRA> convert rfc822-to-8bit; Thu, 25 Oct 2001 15:17:00 -0400
Date: Thu, 25 Oct 2001 15:16:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Shaya Potter <spotter@cs.columbia.edu>
cc: =?ISO-8859-1?Q?Jos=E9?= Luis Domingo =?ISO-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Scheduler and Compilation
In-Reply-To: <1004036810.1770.2.camel@zaphod>
Message-ID: <Pine.LNX.3.95.1011025151158.11665A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 2001, Shaya Potter wrote:

> On Thu, 2001-10-25 at 16:37, José Luis Domingo López wrote:
> > On Thursday, 25 October 2001, at 18:20:25 +0300,
> > Omer Sever wrote:
[SNIPPED...]
> 
> On that note, why is add_to_runqueue() in sched.c and
> del_from_runqueue() in sched.h?

add_to_runqueue() is a function in sched.c
del_from_runqueue() is an macro. Macros generally go into header files.

These kinda need to be associated with sched.c because of:
	static LIST_HEAD(runqueue_head);
	plus some spinlocks.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


