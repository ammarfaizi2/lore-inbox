Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTBCISb>; Mon, 3 Feb 2003 03:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBCISb>; Mon, 3 Feb 2003 03:18:31 -0500
Received: from mail.zmailer.org ([62.240.94.4]:59270 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266114AbTBCISa>;
	Mon, 3 Feb 2003 03:18:30 -0500
Date: Mon, 3 Feb 2003 10:28:00 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Message-ID: <20030203082800.GT821@mea-ext.zmailer.org>
References: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de> <200302030644.h136iXs04935@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302030644.h136iXs04935@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 08:42:59AM +0200, Denis Vlasenko wrote:
> On 3 February 2003 00:55, Tim Schmielau wrote:
> > Just a note that I have rediffed for 2.5.55 the patches that use the
> > 64 bit jiffies value to avoid uptime and process start time wrap
> > after 49.5 days. I will push them Linus-wards when he's back.
> > They can be retrieved from
....
> Wow... your patches are STILL not included??
> My 2.4 based server approaches 250 days uptime, it would be a shame
> to be unable to have uptime < 50 days with 2.5

You don't need to have 64-bit jiffy for things like internal
timers, nor for uptime tracking.

Timers have well behaving constructs to use 32-bit jiffy quite 
successfully, and 64-bit values, especially atomicish, in 32-bit 
register-poor machines (i386) are damn difficult.

I do have a number of machines with 100 to 300 day uptimes, all
with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
one full wrap-around of jiffy.

> --
> vda

/Matti Aarnio
