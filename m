Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWH3IvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWH3IvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWH3IvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:51:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38847 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750702AbWH3IvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:51:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: megaraid_sas suspend ok, resume oops
Date: Wed, 30 Aug 2006 10:54:56 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com> <1156895131.3232.25.camel@nigel.suspend2.net>
In-Reply-To: <1156895131.3232.25.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301054.56375.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 30 August 2006 01:45, Nigel Cunningham wrote:
> On Tue, 2006-08-29 at 20:22 +0800, Jeff Chua wrote:
> > On 8/29/06, Jens Axboe <axboe@kernel.dk> wrote:
> > > On Tue, Aug 29 2006, Jeff Chua wrote:
> > > > Anyone working on suspend/resume for the Megaraid SAS RAID card?
> > > >
> > > > This is on a DELL 2950.
> > > >
> > > > Suspend/resume (to disk) has been running great on my IBM x60s, but
> > > > when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
> > > > suspended ok, but when resuming, the megaraid driver crashed.
> > >
> > > And what exactly is your intention with this email? It can't be getting
> > > the bug fixed, since there's exactly 0% information to help people doing
> > > so :-)
> > >
> > > IOW, provide the oops from the resume crash at least.
> > 
> > The intend is to see if there's already someone working on, and if so,
> > then it'll not be good to post oops that has already been taken care
> > of. I'm trying not to send unnecessary info.
> > 
> > I'll try to get oops in the next few days when I get a chance.
> > Currently traveling.
> > 
> > 
> > Another point ... on IBM x60s notebook, setting ...
> > 
> >        High Memory Support (64GB)
> >                CONFIG_HIGHMEM64G=y
> >                CONFIG_RESOURCES_64BIT=y
> >                CONFIG_X86_PAE=y
> > 
> > will cause resume to "REBOOT" sometimes (may be 6 out of 10).
> > 
> > I was trying to compile a kernel that would run both on the DELL with
> > 16GB RAM, and on my IBM notebook with 2GB RAM.
> > 
> > But without 64 bit support, my notebook will suspend/resume many times
> > without failing (with the 5 ahci patches from Pavel Machek)....
> 
> Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
> at the moment, I'm afraid.
> 
> It's not impossible, we just haven't seen it as a priority worth putting
> time into.

It looks like the Fedora default config has HIGHMEM64G set, so I'll be looking
at it shortly.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
