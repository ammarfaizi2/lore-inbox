Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTIKQhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbTIKQhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:37:51 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:58632
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S261317AbTIKQht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:37:49 -0400
Subject: Re: Lock EVERYTHING (for testing) [was: Re: Scaling noise]
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: John Bradford <john@grabjohn.com>
Cc: davem@redhat.com, miller@techsource.com, anton@samba.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, lm@bitmover.com,
       mbligh@aracnet.com, phillips@arcor.de, piggin@cyberone.com.au
In-Reply-To: <200309101547.h8AFl4Sl002463@81-2-122-30.bradfords.org.uk>
References: <200309101547.h8AFl4Sl002463@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Message-Id: <1063298266.4412.41.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Sep 2003 09:37:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 08:47, John Bradford wrote:
> > The analogy for Linux is this:  At a machine level, we add a check to 
> > EVERY access.  The check is there to ensure that every memory access is 
> > properly locked.  So, if some access is made where there isn't a proper 
> > lock applied, then we can print a warning with the line number or drop 
> > out into kdb or something of that sort.
> >
> > I'm betting there's another solution to this, otherwise, I wouldn't 
> > suggest such an idea, because of the relative amount of work versus 
> > benefit.  But it may require massive modifications to GCC to add this 
> > code in at the machine level.
> 
> Couldn't Valgrind be modified to do this for the kernel?
> 
> http://developer.kde.org/~sewardj/

I have a UML-under-Valgrind project on the backburner.  Valgrind has an
instrumentation mode which checks to see every memory access is covered
by appropriate locks in an MT program.  I'm afraid it will generate a
lot of noise in the kernel though, since there's a lot of code which
does unlocked memory access (probably correctly).

	J

