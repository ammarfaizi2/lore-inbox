Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290056AbSAWUae>; Wed, 23 Jan 2002 15:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290048AbSAWUaY>; Wed, 23 Jan 2002 15:30:24 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:9363 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S290047AbSAWUaK> convert rfc822-to-8bit; Wed, 23 Jan 2002 15:30:10 -0500
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020123201626.2EDEF1458@shrek.lisa.de>
In-Reply-To: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de> 
	<20020123201626.2EDEF1458@shrek.lisa.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 15:29:30 -0500
Message-Id: <1011817776.22707.4.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-23 at 15:16, Hans-Peter Jansen wrote:
> On Tuesday, 22. January 2002 18:15, Daniel Nofftz wrote:
> > hi there!
> >
> [...]
> >
> > if the patch gets a good feedback, maybe it is something for the official
> > kernel tree ?
> >
> > daniel
> 
> Hi Daniel & folks,
> 
> just tried your patch on my (diskless) asus a7v133 (kt133) with 1.2 GHz
> Athlon. I normally had 14% base load spend in apmd-idled and a CPU temp.
> of 45°C. After getting it to work, I see a base load of around 1% (mostly 
> spend in artsd), but CPU is only 1°-2° less now :-( I hoped, it it
> would be more). Nevertheless, it is a very important patch nowadays where
> temperature is the last technical barrier, and energy saving an economic
> necessity.
> 
> Many thanks and greetings from Berlin to Trier ;)
>   Hans-Peter

1-2 degrees is within the sensor's deviation.   Either you dont have it
working correctly or it doesn't work at all in your case.   

You also need acpi idle calls, not just apm.   now this is just my guess
but apm idle calls might either mess things up or be disabled if acpi
idle calls are used and disconnecting the cpu... either way  you can't
have this patch work and apm work at the same time.  

