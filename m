Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbTIKWCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTIKWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:02:06 -0400
Received: from lidskialf.net ([62.3.233.115]:38887 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261579AbTIKWCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:02:03 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: jbarnes@sgi.com (Jesse Barnes)
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Date: Thu, 11 Sep 2003 23:00:30 +0100
User-Agent: KMail/1.5.3
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309112213.13263.adq_dvb@lidskialf.net> <20030911212059.GA27063@sgi.com>
In-Reply-To: <20030911212059.GA27063@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309112300.30882.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Sep 2003 10:20 pm, Jesse Barnes wrote:
> On Thu, Sep 11, 2003 at 10:13:13PM +0100, Andrew de Quincey wrote:
> > > That might work, though I'll be using the ACPI namespace to drive PCI
> > > discovery soon (hacking the PROM now).  Maybe I should add some MADT
> > > and _PRT entries while I'm at it?  The problem is that we don't support
> > > IOAPIC or IOSAPIC interrupt models/hw registers.
> >
> > Which base architecture do you use? x86 and x86_64 ACPI now both support
> > PIC based interrupt models.. as thats the only other option AFAIK (It
> > tries IOAPIC first, then if that fails, it drops back to trying PIC
> > mode).
>
> None of the above.  We have our own NUMAlink based interrupt protocol
> model.

Oooer! Hmm, the existing code would probably NOT like having _PRT entries for 
a model it doesn't know about.... you could add support for it fairly easily 
though I suppose...

