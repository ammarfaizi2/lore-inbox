Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWACNrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWACNrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWACNrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:47:25 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:39352 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750913AbWACNrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:47:24 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@suse.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 3 Jan 2006 13:47:19 +0000
User-Agent: KMail/1.9
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <p7364p1jvkx.fsf@verdi.suse.de>
In-Reply-To: <p7364p1jvkx.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031347.19328.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 13:21, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> >  Documentation/feature-removal-schedule.txt |    7 +
> >  sound/oss/Kconfig                          |   79 ++++++++++++---------
> >  2 files changed, 54 insertions(+), 32 deletions(-)
> >
> > ---
> > linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt.old	
> >2005-07-26 16:50:05.000000000 +0200 +++
> > linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt	2005
> >-07-26 16:51:24.000000000 +0200 @@ -44,0 +45,7 @@
> > +What:	drivers depending on OBSOLETE_OSS_DRIVER
> > +When:	October 2005
> > +Why:	OSS drivers with ALSA replacements
> > +Who:	Adrian Bunk <bunk@stusta.de>
>
> I object to the ICH driver being scheduler for removal. It works
> fine and is a significantly less bloated than the equivalent ALSA setup.
>
> This means ac97_codec.c also has to stay.

I think this is probably true for quite a few of the OSS drivers, versus their 
ALSA equivalents. The fact is that OSS is obsolete, and the ALSA libraries 
and utilities provide, to all soundcards, more features than the OSS API 
could.

Maybe it's more bloated, but it's about time applications on Linux didn't have 
to support 2-3 audio APIs just so they'd work on more than 50% of systems.

It strikes me that it's a bit of a chicken and egg problem. Vendors are still 
releasing applications on Linux that support only OSS, partly due to 
ignorance, but mostly because ALSA's OSS compatibility layer allows them to 
lazily ignore the ALSA API and target all cards, old and new.

Additionally, we can't get rid of OSS compatibility until pretty much all 
hardware has an ALSA driver, and (inferred from your comment) we can't get 
rid of OSS drivers until nothing supports OSS, because the whole of the ALSA 
stuff is a bit larger...

Even if Adrian's not trying to make this point (he's just removing duplicate 
drivers, and opting for the newer ones), we accepted ALSA into the kernel. 
It's probably about time we let OSS die properly, for sanity purposes.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
