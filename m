Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131399AbRACMoH>; Wed, 3 Jan 2001 07:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRACMn4>; Wed, 3 Jan 2001 07:43:56 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:18095 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131399AbRACMno>; Wed, 3 Jan 2001 07:43:44 -0500
Date: Wed, 3 Jan 2001 14:12:20 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Sklar <sklarm@screwdecaf.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5
Message-ID: <20010103141220.A812@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0012292007510.11006-100000@d13.com> <Pine.LNX.4.21.0101030942430.1403-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0101030942430.1403-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jan 03, 2001 at 09:43:54AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 09:43:54AM -0200, Rik van Riel wrote:
> On Fri, 28 Dec 2000, Mike Sklar wrote:
> > If I wanted to adjust the rlim_cur value of a running
> > processes, is there any sort of interface for that?
> 
> Hmmm, I don't think there is an interface to adjust the
> per-process ulimit settings on-the-fly ...
> 
> Does anybody know if there's an interface for this ?

If you don't mean "kill -TERM", no there isn't. It would be evil
to the process anyway.

Some[1] programs ask their resource limits on startup to scale to a
sane amount of memory usage for caching, operation buffers and
the like. If your readjust it to sth. smaller, they'll be killed
soon and if you readjust to sth, bigger, they wouldn't use it.


Regards

Ingo Oeser

[1] I would like to write "most programs", but most programs
   assume, that they will never run out of memory and leave it to
   the administrator/user to care for this issue :-(
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
