Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWFANpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFANpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFANpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:45:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:290 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750959AbWFANpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:45:51 -0400
Date: Thu, 1 Jun 2006 15:48:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata resume fix
Message-ID: <20060601134802.GK4400@suse.de>
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it> <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it> <6iH3h-2xw-59@gated-at.bofh.it> <447E5EAD.5070808@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E5EAD.5070808@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Robert Hancock wrote:
> Bill Davidsen wrote:
> >The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
> >lot of design changes to make it spin up quickly, and improve a function 
> >which is usually done on a server once every MTBF when replacing the 
> >failed unit.
> >
> >I think the majority of very large or very fast drives are in systems 
> >which don't (deliberately) power cycles often, in rooms where heat is an 
> >issue. And to spin up quickly take a larger power supply... 30 sec is 
> >fine with most users.
> >
> >Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
> >seek sure is fast!
> 
> I wouldn't guess that even a 15K drive would take nearly that long. For 
> boot time on servers it doesn't matter much though, disk spinup time is 

I do use a 15K rpm drive in my workstation (hello git!), and the spin up
really isn't that bad. Less than 10 seconds for the actual spin up, I
would say.

> in the noise compared to the insane BIOS delays on most of them during 
> bootup. Like on some servers (ahem.. IBM) which have about a 15 second 
> delay on the main BIOS screen, 10 second delays on every network boot 
> ROM, a 1 minute delay on the SCSI controller before it even starts 
> scanning the bus, then another good 10 seconds before it starts booting. 
> Gets annoying after a few reboots..

Indeed, the BIOS bootup time on servers is typically anywhere from
really bad to truly awful.

-- 
Jens Axboe

