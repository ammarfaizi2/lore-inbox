Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbRFPULs>; Sat, 16 Jun 2001 16:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264652AbRFPULi>; Sat, 16 Jun 2001 16:11:38 -0400
Received: from [209.250.53.182] ([209.250.53.182]:13572 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264651AbRFPULU>; Sat, 16 Jun 2001 16:11:20 -0400
Date: Sat, 16 Jun 2001 15:10:14 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Josh Myer <jbm@joshisanerd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning in tdfxfb.c
Message-ID: <20010616151014.A2086@hapablap.dyn.dhs.org>
In-Reply-To: <20010616133243.A1610@hapablap.dyn.dhs.org> <Pine.LNX.4.21.0106161452270.1755-100000@dignity.joshisanerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106161452270.1755-100000@dignity.joshisanerd.com>; from jbm@joshisanerd.com on Sat, Jun 16, 2001 at 02:59:34PM -0500
X-Uptime: 3:07pm  up  1:29,  0 users,  load average: 1.38, 1.30, 1.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2001 at 02:59:34PM -0500, Josh Myer wrote:
> It might be better to add a default case to the switch statement below, so
> this symbol doesn't just eat up another 4(8 on some platforms, and i'm
> sure others) bytes of memory unneccesarily.

I'm not quite sure I follow you.  The default case should never be
reached, because only the three cases currently present are allowed by
the encapsulating 'if' statement.  Even so, how would adding a default
case get rid of the variable or save space some other way?

> anyway, it doesn't really matter. i'd test my hypothesis, but i've got
> people coming over this afternoon =) the driver looks like it might use
> some scrubbing anyway (s!//(.*)$!/\* $1 \*/!...)

Good point.  Perhaps I'll prepare a larger patch with this and other
cleanups.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
