Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265807AbSKAWcu>; Fri, 1 Nov 2002 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbSKAWcu>; Fri, 1 Nov 2002 17:32:50 -0500
Received: from nameservices.net ([208.234.25.16]:34923 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265807AbSKAWch>;
	Fri, 1 Nov 2002 17:32:37 -0500
Message-ID: <3DC30370.46637A01@opersys.com>
Date: Fri, 01 Nov 2002 17:42:56 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: David Lang <david.lang@digitalinsight.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com> <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com> <20021101192545.F2599@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
> But for a general solution, it seems more appropriate to me to solve
> the problem of moving the kernel data from the damaged system to an
> intact system only once, e.g. using the MCORE approach, than over
> and over again for all possible types of hardware and attachment
> methods.

This is just a random tangential thought here, but FWIW:

Why not just have a simple backup stripped-down "hardened" copy of Linux
lying around in a physical RAM region not used by the copy of Linux
actually running. Granted the running Linux doesn't do random physical
accesses when dying, the crash handler could then just boot that
secondary Linux which would then have a RAM disk containing the
appropriate scripts and binaries to handle the actual crash. Given the
cost of RAM these days, reserving a MB or two for this purpose should
probably not be that bad.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
