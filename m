Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288288AbSAHUaZ>; Tue, 8 Jan 2002 15:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288290AbSAHUaF>; Tue, 8 Jan 2002 15:30:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:40717 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288288AbSAHUaA>; Tue, 8 Jan 2002 15:30:00 -0500
Message-ID: <3C3B5580.63DB0760@zip.com.au>
Date: Tue, 08 Jan 2002 12:24:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br> <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>,
		<Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jan 08, 2002 at 11:59:36AM -0200 <20020108163925.F1894@inspiron.school.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> > What is 00_nanosleep-5 and bootmem ?
> 
> nanosleep gives usec resolution to the rest-of-time returned by
> nanosleep, this avoids glibc userspace starvation on nanosleep
> interrupted by a flood of signals. It was requested by glibc people.
> 

It would be really nice to do something about that two millisecond
busywait for RT tasks in sys_nanosleep().  It's really foul.

The rudest thing about it is that programmers think "oh, let's
be nice to the machine and use usleep(1000)".  Boy, do they
get a shock when they switch their pthread app to use an
RT policy.

Does anyone have any clever ideas?

-
