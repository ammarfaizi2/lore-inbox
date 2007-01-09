Return-Path: <linux-kernel-owner+w=401wt.eu-S932110AbXAIOKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbXAIOKF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbXAIOKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:10:04 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:50170 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbXAIOKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:10:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pxHld9eKCfnOOvsqrOJbWehLwYFFnChFCbMD5I33nTcJ3hLNmNthRRudxSP5tg4/TFg6R5LjIuw7Em2XRyAzLmY7wgOKr+gg8fmasJQeOcj101NG7d/4Xv+8rubWREbY04RC57t22zEmVu9bJt4AGF5QaEdthxHK03L79PY0Kb8=
Message-ID: <58cb370e0701090610k586ffc5aqffc371144485bc8f@mail.gmail.com>
Date: Tue, 9 Jan 2007 15:10:00 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Conke Hu" <conke.hu@gmail.com>
Subject: Re: [PATCH 1/3] atiixp.c: remove unused code
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       linux-ide@vger.kernel.org
In-Reply-To: <5767b9100701090328o4b78fd4x2b18a42a996608d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
	 <58cb370e0701061812s49c4b1f5p5c5e99e5eea3bb89@mail.gmail.com>
	 <5767b9100701090328o4b78fd4x2b18a42a996608d9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Conke Hu <conke.hu@gmail.com> wrote:
> On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > > A previous patch to atiixp.c was removed but some code has not been
> >
> > This one?
> >
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3
> >
> > Doesn't it break existing setups without giving ANY warning?
> >
> > theoretical (I don't have hardware in question) scenario:
> > - user uses atiixp and has modular libata/ahci (or no libata/ahci et all)
> > - user does kernel upgrade
> > - boot fails
> > - ...
> >
> > If this is true please add something like
> >
> > printk(KERN_WARNING "PCI: setting SB600 SATA to AHCI mode"
> > " (please use ahci driver instead of atiixp)\n");
> >
> > to quirk_sb600_sata() so people will at least know what is wrong...
> >
> > > cleaned. Now we remove these code sine they are no use any longer.
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >
> > [ but the patch is line wrapped and unfortunately doesn't apply ]
> >
> > PS: please always cc: linux-ide@vger.kernel.org on PATA/SATA patches
> >
> > Thanks,
> > Bart
> >
>
>
> Hi Bart,
>     I've tried to access the following link to make sure which it is,
> but failed. The internet here   is almost broken.
>     http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3

Yeah, kernel.org is heaving some load related problems.

>    I sent out 2 patches for the same SB600 legacy IDE issue. the later
> (sb600 pci qurik) is better so we should clean the previous patch
> which was applied to atiixp.c. -- that is what this patch does.

Yep, I was talking about "PCI: ATI sb600 sata quirk" which was merged
into -rc2.

>     BTW, I re-create and re-send the patch (see below) based on
> 2.6.20-rc4, in last patch I fogot to rename atiixp.c.1 to atiixp.c
> which may lead to patch fail, nothing else different.
>     And maybe no need to re-ACK if last one is accepted:)

As stated in the other mail - these patches are in -mm kernel already.

Thanks,
Bart
