Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbTC1HNr>; Fri, 28 Mar 2003 02:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbTC1HNr>; Fri, 28 Mar 2003 02:13:47 -0500
Received: from [196.41.29.142] ([196.41.29.142]:36084 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S262239AbTC1HNq>; Fri, 28 Mar 2003 02:13:46 -0500
Subject: Re: lm sensors sysfs file structure
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030327231027.GC1687@kroah.com>
References: <1048806052.10675.4440.camel@cube>
	 <20030327231027.GC1687@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048836107.4776.2285.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 28 Mar 2003 09:21:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 01:10, Greg KH wrote:
> On Thu, Mar 27, 2003 at 06:00:51PM -0500, Albert Cahalan wrote:
> > Greg KH writes:
> > 
> > > temp_max[1-3]   Temperature max value.
> > >                 Fixed point value in form XXXXX and
> > >                 should be divided by
> > >                 100 to get degrees Celsius.
> > >                 Read/Write value.
> > 
> > Celsius can go negative, which may be yucky
> > and hard to test. Kelvin generally doesn't
> > suffer this problem. (yeah, yeah, quantum stuff...)
> 
> Wow, only 4 hours before someone mentioned Kelvin, I think I lost a bet
> with someone :)
> 
> Seriously, let the value go negative, no problem.  As long as it isn't
> floating point input which has to be parsed by the kernel.  That's all I
> care about.
> 

Silly w83781d again.  temp1 is a u8, and temp2 and temp3 is u16
(if they are supported on the specific model.

Should we do any bounds checking on input via sysfs ?


Regards,
-- 
Martin Schlemmer


