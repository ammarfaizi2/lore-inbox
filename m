Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSGIUMH>; Tue, 9 Jul 2002 16:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSGIUMG>; Tue, 9 Jul 2002 16:12:06 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:11283 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317391AbSGIUMF>;
	Tue, 9 Jul 2002 16:12:05 -0400
Date: Tue, 9 Jul 2002 13:12:13 -0700
From: Greg KH <greg@kroah.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020709201213.GB27999@kroah.com>
References: <20020709043857.GA24418@kroah.com> <200207091933.g69JXE417419@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091933.g69JXE417419@eng4.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 11 Jun 2002 18:21:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:33:13PM -0700, Rick Lindsley wrote:
>     Wait!  You're still not getting it.  I'm not against removing the
>     BKL.  I'm not saying we should add it to more places.  What I am
>     complaining about (and I'm not the only one) is the method that
>     people who are trying to remove the BKL from various kernel
>     subsystems are using.
> 
>     [ ... ]
> 
>     So please, no more "hit and run" BKL patches that break things.
>     Please come offering to help, with detailed reasons why BKL usage
>     is wrong in the specific portions of the code, and how possibly it
>     might be cleaned up, with patches that have _actually been
>     tested_.
> 
> I understand.  But there's a bit of a problem here.  We don't have
> every device available to us that uses the BKL.

Wait.  The patches I specifically mention are in regards to devices that
both of you should have access to.  If not, you could have simply walked
over and asked me for one.  A single USB mouse or keyboard would have
proved that both the input and the driverfs patches were wrong.  Since
the patch was for these types of subsystems, not even attempting to test
it out is indefensible.

> The maintainers, I presume, do.

This too is incorrect.  I do not have some devices for drivers that I
have created and maintain.  I think this is also true for the majority
of the joystick drivers.  Granted, this isn't the best thing, but
companies aren't giving us free devices to write our free drivers for.
We rely on users for testing sometimes (debugging through email does
work, albeit slowly :)

> What is the proper response when a maintainer won't apply a change,
> won't help test it, and won't even help derive a correct one?

Post it to a public mailing list (like lkml) where people in general
care about these things.  Enough hounding will either shame the
maintainer into replying, or you might find yourself becoming the
maintainer if no one steps up (like ATM :)


greg k-h
