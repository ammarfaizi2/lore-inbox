Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVBCFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVBCFvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVBCFvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:51:11 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18863 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262835AbVBCFu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:50:57 -0500
Subject: Re: kdump on non-boot cpu
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050203140438.18E1.ODA@valinux.co.jp>
References: <20050203140438.18E1.ODA@valinux.co.jp>
Content-Type: text/plain
Organization: 
Message-Id: <1107412952.11609.174.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Feb 2005 12:12:32 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 10:42, Itsuro Oda wrote:
> Hi,
> 
> I found the following in an old mail:
> 
> >From vgoyal at in.ibm.com  Thu Jan  6 07:20:43 2005
> ...
> >2. Kdump can possibly fail on SMP machines if crash occurs on non-boot
> >cpu. Hari is finalizing the stop gap patch to handle this problem.
> 
> Is this finished ?  (It seems it is not in 2.6.11-rc2-mm1.)

Not yet. For the time being focus got shifted to other kdump issues. I
am not even sure if this is a problem. See below a clip from discussions
on fastboot.

> Hi Eric,
> > 
> > I had a quick look at kexec3. Had some queries.
> > 
> > 1. Code for relocating to boot cpu or enabling boot from non-boot cpu is
> > required.
> 
> Actually I just looked and it appears this snippet from smp_boot_cpus
> already handles that case.
> 
>         boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
>         boot_cpu_logical_apicid = logical_smp_processor_id();
>         x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
> 
> While looking I certainly did not see anything still in the
> kernel that would complain if we get this wrong.
> 
> Although I  am not really comfortable with a capture kernel using
> multiprocessors. 
> 
> Eric


Do you see a problem in the code flow somewhere?

Vivek

