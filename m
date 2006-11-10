Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424256AbWKJEvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424256AbWKJEvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424279AbWKJEvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:51:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35026 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424256AbWKJEvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:51:37 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
Date: Fri, 10 Nov 2006 05:49:08 +0100
User-Agent: KMail/1.9.5
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, NeilBrown <neilb@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611091642.01453.rjw@sisk.pl> <20061109095811.ac654e13.akpm@osdl.org>
In-Reply-To: <20061109095811.ac654e13.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100549.08239.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > 
> > > Well, I've got some data from earlyprintk (forgot I needed to boot with
> > > vga=normal).
> > > 
> > > Unfortunately, I had to rewrite the trace manually:
> > > 
> > > clear_IO_APIC_pin+0x15/0x6a
> > > try_apic_pin+0x7a/0x98
> > > setup_IO_APIC+0x600/0xb7a
> > > smp_prepare_cpus+0x33a/0x371
> > > init+0x60/0x32d
> > > child_rip+0xa/0x12
> > > 
> > > [And then the unwinder said it got stuck.]
> > > 
> > > RIP is reported to be at ioapic_read_entry+0x33/0x61,
> > 
> > This is 100% reproducible on the nx6325 (but not on the other boxes) and
> > apparently caused by x86_64-mm-try-multiple-timer-pins.patch (doesn't
> > happen with this patch reverted).
> 
> Thanks, dropped.

can I have details please? 

On what system (CPU, motherboard, BIOS version) does the noidlehz stuff break?
And what did you drop exactly?


Thanks,

-Andi
