Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbTIKVVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTIKVVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:21:10 -0400
Received: from zok.SGI.COM ([204.94.215.101]:22670 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261536AbTIKVVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:21:03 -0400
Date: Thu, 11 Sep 2003 14:20:59 -0700
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030911212059.GA27063@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309112140.08967.adq_dvb@lidskialf.net> <20030911205310.GA26569@sgi.com> <200309112213.13263.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309112213.13263.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 10:13:13PM +0100, Andrew de Quincey wrote:
> > That might work, though I'll be using the ACPI namespace to drive PCI
> > discovery soon (hacking the PROM now).  Maybe I should add some MADT and
> > _PRT entries while I'm at it?  The problem is that we don't support
> > IOAPIC or IOSAPIC interrupt models/hw registers.
> 
> Which base architecture do you use? x86 and x86_64 ACPI now both support PIC 
> based interrupt models.. as thats the only other option AFAIK (It tries 
> IOAPIC first, then if that fails, it drops back to trying PIC mode).

None of the above.  We have our own NUMAlink based interrupt protocol
model.

> > > 2) If ACPI is enabled, and enters the function you patched, code further
> > > in checks if the routing tables have any entries. If not, it rejects the
> > > attempt.
> >
> > That would work I guess.
> 
> Cool, well if it doesn't work, at least we know exactly what to fix.

Yeah, I found the problem pretty quickly last time, so I'm ok with
retesting once your patch goes in.

Thanks,
Jesse
