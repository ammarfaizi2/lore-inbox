Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWCUXtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWCUXtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWCUXtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:49:36 -0500
Received: from nacho.alt.net ([207.14.113.18]:14763 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1750825AbWCUXtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:49:35 -0500
Date: Tue, 21 Mar 2006 23:49:32 +0000 (GMT)
To: Dax Kelson <dax@gurulabs.com>
cc: linux-kernel@vger.kernel.org, erich@areca.com.tw
Subject: Re: New Areca driver in 2.6.16-rc6-mm2
In-Reply-To: <Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com>
Message-ID: <Pine.LNX.4.64.0603212345460.20655@nacho.alt.net>
References: <20060318044056.350a2931.akpm@osdl.org>
	<Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2006, Dax Kelson wrote:
> On Sat, 18 Mar 2006, Andrew Morton wrote:
> > SCSI fixes
> >
> > +areca-raid-linux-scsi-driver-update4.patch
> >
> > Update areca-raid-linux-scsi-driver.patch
> 
> Has anyone had a chance to review this new update to see if it now passes
> muster for mainline inclusion?

Unfortunately when the new driver is applied to 2.6.15.6 a bonnie++ test 
results in the following endless spew:

  ...
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  ...

I have emailed the details to Erich.

Chris
