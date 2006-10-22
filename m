Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWJVQTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWJVQTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWJVQTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:19:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:8165 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751159AbWJVQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:19:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCb/3pm8vTZSSipxzYLB0wz/qXkC5ish1iJAwOqY6+58dRrpt+Hh5TjH0uYq4INoF1Fh+a0JtnxO5DSlxDY84Ke76213snZIHGDe5Og4wSkIWAFruzHGjywBDGyne3Cm/hwVO6s5CaK05+wFRgYZD4uV6wKIOfRkwXjgW/vu8Ho=
Message-ID: <86802c440610220919h5e2fb98axb5ba4dd4d073171@mail.gmail.com>
Date: Sun, 22 Oct 2006 09:19:09 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
	 <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
	 <20061022085036.GP5211@rhun.haifa.ibm.com>
	 <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

the per_cpu only can be used with online cpus?

YH

On 10/22/06, yhlu <yhlu.kernel@gmail.com> wrote:
> You must have NR_CPUS=4.
>
> Also you genapic is running on flat. (logical)
>
> Can you try to set NR_CPUS=8 and without this patch?
>
> YH
>
> On 10/22/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > On Sun, Oct 22, 2006 at 01:28:03AM -0700, Yinghai Lu wrote:
> > > On 10/21/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > > >>
> > > >> typo with cpu instead of new_cpu
> > > >
> > > >This patch breaks my x366 machine:
> > > >
> > > >aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys,
> > > >8 enabled phys, flash present, BIOS build 1323
> > > >aic94xx: couldn't get irq 25 for 0000:01:02.0
> > > >ACPI: PCI interrupt for device 0000:01:02.0 disabled
> > > >aic94xx: probe of 0000:01:02.0 failed with error -38
> > > >
> > > >Reverting it allows it to boot again. Since the patch is "obviously
> > > >correct", it must be uncovering some other problem with the genirq
> > > >code.
> > > >
> > >
> > > can you try attached patch? it use cpu_online_map instead of 0xff.
> >
> > Works!
> >
> > Thanks,
> > Muli
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
