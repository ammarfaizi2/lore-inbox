Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271416AbTHKGCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271417AbTHKGCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:02:54 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:11654
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271416AbTHKGCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:02:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Martin Schlemmer <azarah@gentoo.org>
Subject: Re: [PATCH]O14int
Date: Mon, 11 Aug 2003 16:08:18 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308090149.25688.kernel@kolivas.org> <200308091904.19222.kernel@kolivas.org> <1060580691.13254.7.camel@workshop.saharacpt.lan>
In-Reply-To: <1060580691.13254.7.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308111608.18241.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 15:44, Martin Schlemmer wrote:
> On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
> > On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
> > > More duck tape interactivity tweaks
> >
> > s/duck/duct
> >
> > > Wli pointed out an error in the nanosecond to jiffy conversion which
> > > may have been causing too easy to migrate tasks on smp (? performance
> > > change).
> >
> > Looks like I broke SMP build with this. Will fix soon; don't bother
> > trying this on SMP yet.
>
> Not to be nasty or such, but all these patches have taken
> a very responsive HT box to one that have issues with multiple
> make -j10's running and random jerkyness.

A UP HT box you mean? That shouldn't be capable of running multiple make -j10s 
without some noticable effect. Apart from looking impressive, there is no 
point in having 30 cpu heavy things running with only 1 and a bit processor 
and the machine being smooth as silk; the cpu heavy things will just be 
unfairly starved in the interest of appearance (I can do that easily enough). 
Please give details if there is a specific issue you think I've broken or 
else I wont know about it.

> I am not so sure I for one want changes to the scheduler for
> SMP (not UP interactivity ones anyhow).

They're not; the improvements should affect fairness on SMP as well and 
although interactivity is what I'm addressing on the surface, fairness is the 
real issue.

Con.

