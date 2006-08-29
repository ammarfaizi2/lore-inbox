Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWH2Xp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWH2Xp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWH2Xp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 19:45:57 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:7058 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751466AbWH2Xp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 19:45:56 -0400
Subject: Re: megaraid_sas suspend ok, resume oops
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sreenivas.Bagalkote@lsil.com,
       Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
	 <20060829081518.GD12257@kernel.dk>
	 <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 09:45:31 +1000
Message-Id: <1156895131.3232.25.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-08-29 at 20:22 +0800, Jeff Chua wrote:
> On 8/29/06, Jens Axboe <axboe@kernel.dk> wrote:
> > On Tue, Aug 29 2006, Jeff Chua wrote:
> > > Anyone working on suspend/resume for the Megaraid SAS RAID card?
> > >
> > > This is on a DELL 2950.
> > >
> > > Suspend/resume (to disk) has been running great on my IBM x60s, but
> > > when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
> > > suspended ok, but when resuming, the megaraid driver crashed.
> >
> > And what exactly is your intention with this email? It can't be getting
> > the bug fixed, since there's exactly 0% information to help people doing
> > so :-)
> >
> > IOW, provide the oops from the resume crash at least.
> 
> The intend is to see if there's already someone working on, and if so,
> then it'll not be good to post oops that has already been taken care
> of. I'm trying not to send unnecessary info.
> 
> I'll try to get oops in the next few days when I get a chance.
> Currently traveling.
> 
> 
> Another point ... on IBM x60s notebook, setting ...
> 
>        High Memory Support (64GB)
>                CONFIG_HIGHMEM64G=y
>                CONFIG_RESOURCES_64BIT=y
>                CONFIG_X86_PAE=y
> 
> will cause resume to "REBOOT" sometimes (may be 6 out of 10).
> 
> I was trying to compile a kernel that would run both on the DELL with
> 16GB RAM, and on my IBM notebook with 2GB RAM.
> 
> But without 64 bit support, my notebook will suspend/resume many times
> without failing (with the 5 ahci patches from Pavel Machek)....

Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
at the moment, I'm afraid.

It's not impossible, we just haven't seen it as a priority worth putting
time into. Do you really have more than 4GB of RAM and want to suspend
to disk?

Regards,

Nigel

