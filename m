Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWH2MWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWH2MWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWH2MWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:22:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:5163 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751091AbWH2MWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:22:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WrJYsdySzJSDf9XmWe75amteZ+7GFxeFbGDssvFx04nTe3nKHKA3ibu0cNmkgd/xXWGYeU6Z62lhP8TwP+d3nwccphzvLz8Q8mM2udnmmgMzxFkBJ48yIl8aaS0OwhS1Ktdh1Ou2NNpgUeG3VqnSEUsn5dW00uieqeemFipLwgE=
Message-ID: <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
Date: Tue, 29 Aug 2006 20:22:31 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Jens Axboe" <axboe@kernel.dk>
Subject: Re: megaraid_sas suspend ok, resume oops
Cc: Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060829081518.GD12257@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
	 <20060829081518.GD12257@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Jens Axboe <axboe@kernel.dk> wrote:
> On Tue, Aug 29 2006, Jeff Chua wrote:
> > Anyone working on suspend/resume for the Megaraid SAS RAID card?
> >
> > This is on a DELL 2950.
> >
> > Suspend/resume (to disk) has been running great on my IBM x60s, but
> > when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
> > suspended ok, but when resuming, the megaraid driver crashed.
>
> And what exactly is your intention with this email? It can't be getting
> the bug fixed, since there's exactly 0% information to help people doing
> so :-)
>
> IOW, provide the oops from the resume crash at least.

The intend is to see if there's already someone working on, and if so,
then it'll not be good to post oops that has already been taken care
of. I'm trying not to send unnecessary info.

I'll try to get oops in the next few days when I get a chance.
Currently traveling.


Another point ... on IBM x60s notebook, setting ...

       High Memory Support (64GB)
               CONFIG_HIGHMEM64G=y
               CONFIG_RESOURCES_64BIT=y
               CONFIG_X86_PAE=y

will cause resume to "REBOOT" sometimes (may be 6 out of 10).

I was trying to compile a kernel that would run both on the DELL with
16GB RAM, and on my IBM notebook with 2GB RAM.

But without 64 bit support, my notebook will suspend/resume many times
without failing (with the 5 ahci patches from Pavel Machek)....

>>This is the take 5 of AHCI suspend/resume patches.
>>The patch is against libata #upstream.
>>Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
>>Signed-off-by: Hannes Reinecke <hare@suse.de>
>>Signed-off-by: Jens Axboe <axboe@suse.de>
>>Signed-off-by: Pavel Machek <pavel@suse.cz>

For this, there's no oops, suspend ok, but upon resume, screen will go
blank, then reboot. With or without X, and console after fresh
startup, same reboot.

Sorry, I don't know how to get oops info, but whatever I can do to
trace down the bug, please show me how.

I'll do anything to make Linux more robust!!! Please lead the way.

Thank,
Jeff.
