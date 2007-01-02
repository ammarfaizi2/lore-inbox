Return-Path: <linux-kernel-owner+w=401wt.eu-S1754884AbXABSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbXABSnL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbXABSnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:43:10 -0500
Received: from hera.kernel.org ([140.211.167.34]:43891 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884AbXABSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:43:09 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: x86 instability with 2.6.1{8,9}
Date: Tue, 2 Jan 2007 13:42:32 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070101160158.GA26547@deepthought> <200701021225.57708.lenb@kernel.org> <20070102180425.GA18680@deepthought>
In-Reply-To: <20070102180425.GA18680@deepthought>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021342.32195.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 January 2007 13:04, Ken Moffat wrote:
> On Tue, Jan 02, 2007 at 12:25:57PM -0500, Len Brown wrote:
> > > it's been nothing but trouble in 32-bit mode.
> > > It still works fine when I boot it in 64-bit mode. 
> > 
> > A shot in the dark at the spontaneous reset issue, but no clue on the 32 vs 64-bit observation...
> > 
> > See if ACPI exports any temperature readings under /proc/acpi/thermal_zone/*/temperature
> > and if so, keep an eye on them to see if there is an indication of a thermal problem.
> > 
> > ( And if ACPI doesn't, maybe lmsensors can find something.)
> > 
> > cheers,
> > -Len
> 
>  Thanks, but there is nothing there.  I never managed to get
> lmsensors configured (as in 'calibrated') for the hardware I tried it
> on, but I was starting to think about retrying it.  But first, I'm
> just about to start testing with memtest86+ in case something in the
> memory has gone bad.

You might remove and re-insert the DIMMS.
Sometimes there are poor contacts if the DIMMS are not fully seated and clicked in.

The real mystery is the 32 vs 64-bit thing.
Are the devices configured the same way -- ie are they both in IOAPIC mode
and /proc/interrupts looks the same for both modes?

-Len
