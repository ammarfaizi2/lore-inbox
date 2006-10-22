Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWJVIun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWJVIun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWJVIun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:50:43 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:51927 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932284AbWJVIuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:50:40 -0400
Date: Sun, 22 Oct 2006 10:50:36 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022085036.GP5211@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 01:28:03AM -0700, Yinghai Lu wrote:
> On 10/21/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> >>
> >> typo with cpu instead of new_cpu
> >
> >This patch breaks my x366 machine:
> >
> >aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 
> >8 enabled phys, flash present, BIOS build 1323
> >aic94xx: couldn't get irq 25 for 0000:01:02.0
> >ACPI: PCI interrupt for device 0000:01:02.0 disabled
> >aic94xx: probe of 0000:01:02.0 failed with error -38
> >
> >Reverting it allows it to boot again. Since the patch is "obviously
> >correct", it must be uncovering some other problem with the genirq
> >code.
> >
> 
> can you try attached patch? it use cpu_online_map instead of 0xff.

Works!

Thanks,
Muli
