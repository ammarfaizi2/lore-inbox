Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264046AbRFNUwT>; Thu, 14 Jun 2001 16:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264053AbRFNUwJ>; Thu, 14 Jun 2001 16:52:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21516 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264046AbRFNUvz>; Thu, 14 Jun 2001 16:51:55 -0400
Date: Thu, 14 Jun 2001 17:51:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: John Stoffel <stoffel@casc.com>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <15145.8435.312548.682190@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33.0106141750260.28370-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, John Stoffel wrote:

> That could be handled by a metric which says if the disk is spun down,
> wait until there is more memory pressure before writing.  But if the
> disk is spinning, we don't care, you should start writing out buffers
> at some low rate to keep the pressure from rising too rapidly.
>
> The idea of buffers is more to keep from overloading the disk
> subsystem with IO, not to stop IO from happening at all.  And to keep
> it from going from no IO to full out stalling the system IO.  It
> should be a nice line as VM pressure goes up, buffer flushing IO rate
> goes up as well.

There's another issue.  If dirty data is written out in
small bunches, that means we have to write out the dirty
data more often.

This in turn means extra disk seeks, which can horribly
interfere with disk reads.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

