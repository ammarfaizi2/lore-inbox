Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311411AbSCMW3Z>; Wed, 13 Mar 2002 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311414AbSCMW3Q>; Wed, 13 Mar 2002 17:29:16 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:52949 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311411AbSCMW3L>; Wed, 13 Mar 2002 17:29:11 -0500
To: haveblue@linux.ibm.com
cc: walter <walt@nea-fast.com>, linux-kernel@vger.kernel.org,
        davis@jdhouse.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: oracle rmap kernel version 
In-Reply-To: Your message of Wed, 13 Mar 2002 13:11:01 PST.
             <3C8FC065.4060904@us.ibm.com> 
Date: Wed, 13 Mar 2002 14:27:27 -0800
Message-Id: <E16lHE7-0005tp-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IPS/ServerRAID driver can work with the siorl patch - just isn't in
the lse02 rollup.  It will probably be in the lse04 rollup once I get done
testing the lse03 rollup.  ;-)

If the source if available for a particular driver and you are interested
in some level of IO scalability in a 2.4 kernel, we have a fairly robust
patch that can easily be made to work.  If the driver is reasonably
written, the modification to support the siorl patch is just to enable
the feature.  If it is not well written, we might need to take a look
at the locking model used and propose a few mods.  BTW, IDE is not
"well written" from this perspective.  Also, I believe the some future
Red Hat kernel will include a more wide-sweeping version of the siorl
patch which may support all drivers out of the box.

gerrit

In message <3C8FC065.4060904@us.ibm.com>, > : haveblue@linux.ibm.com writes:
> 
> 
> 
> To:    walter <walt@nea-fast.com>
> cc:    linux-kernel@vger.kernel.org, davis@jdhouse.org, Gerrit Huizenga
>        <gerrit@us.ibm.com>
> 
> 
> 
> 
> 
> walter wrote:
> > Not sure right off the top of my head. I'm planning on using 2
> controllers,
> > each from a different manufactures. My reasoning behind this is two fold.
> > Number one is in case a "bug" creeps up with one of the drivers I can
> still
> > string all the drives off the other controller. Performance will
> decrease,
> > but I'd rather be slow than dead in the water. The second reason is the
> > probability of both controllers failing (hardware) at same time due to a
> bad
> > chip batch at the manufacture.  Do you have any suggestions on
> controllers?
> > Adaptec and IBM (not sure which models) ?
> 
> I haven't done any of the testing myself.  But, I was told that the
> Adaptec AIC stuff is good.  I think that the LSE patch has been tested
> on with Adaptec (aic7xxx) and QLogic fiber channel controllers.  I guess
> that the QLogic stuff is liked because the drivers are open source.
> 
> I was surprised to see that the ServeRAID driver isn't touched by the
> lse patch.  I thought that it still uses the io_request_lock in 2.4.
> 
> Care to add anything, Gerrit?
> 
> --
> Dave Hansen
> haveblue@us.ibm.com
