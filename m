Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSGCQta>; Wed, 3 Jul 2002 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGCQtX>; Wed, 3 Jul 2002 12:49:23 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:54749 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317191AbSGCQr5>; Wed, 3 Jul 2002 12:47:57 -0400
Date: Wed, 3 Jul 2002 02:59:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, Nick Bellinger <nickb@attheoffice.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020703005922.GA112@elf.ucw.cz>
References: <Pine.LNX.4.33.0206250920150.8496-100000@geena.pdx.osdl.net> <3D18AD30.7040904@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D18AD30.7040904@pacbell.net>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style
> >>hookup for iSCSI devices?  Using whatever physical addressing the
> >>kernel uses there, which I assume wouldn't necessarily be restricted
> >>to ipv4.  (And not exposing physical network topology -- routing! --
> >>in driverfs.)
> >
> >
> >You can very well use driverfs to expose those attributes, and is one of 
> >the things that we've been discussing at the kernel summit. driverfs will 
> >take over the world. But, I still think the device is best represented as 
> >a child of the phsysical network device. 
> 
> Which one?  I'd certainly hope that drivers wouldn't have to choose which
> of the various network interfaces to register under, or register under
> every network interface concurrently.  (Or only the ones they might
> conceivably be routed to go out on...)  Given a bonded network link (going
> out over multiple physical drivers) that'd get hairy.  And what about
> devices that host several logical interfaces?  Or when the interfaces get
> moved to some other device?
> 
> That's why I think a "non-physical" tree (not under $DRIVERFS/root) is more
> sensible in such cases.  Which is not to say it's without additional issues
> (like how to establish/maintain driver linkages that are DAGs not single
> parent trees) but it wouldn't require drivers to dig as deeply into
> >>lower

Hmm, are dags enough?

I mean, cycles exist in IP based networks, and I don't see a reason
why it could not exist with some kind of advanced fibrechannel.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
