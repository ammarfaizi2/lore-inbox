Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTJUUVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTJUUVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:21:46 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:49087 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263317AbTJUUVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:21:43 -0400
Date: Tue, 21 Oct 2003 22:01:14 +0200
From: Dominik Brodowski <linux@brodo.de>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-statedriver
Message-ID: <20031021200114.GB26971@brodo.de>
References: <CFF522B18982EA4481D3A3E23B83141C24B4BC@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF522B18982EA4481D3A3E23B83141C24B4BC@orsmsx407.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 10:12:14AM -0700, Moore, Robert wrote:
> 
> This is exactly what I was looking at doing, looks like most of the work
> is done.  I have some concerns about the actual algorithm used for
> changing the CPU frequency (20%/80%), but this of course can be tuned.

Well, so write a different governor, and feel free to use Venkatesh's code
as a base [it's GPLed, after all...]. I prefer to have several different 
governors available, so that different users with different needs
can use different "policies".

> I suspect that CPUs that have the capability of changing frequency
> themselves would not use this particular governor.

They can't -- If the driver for Transmeta CPUs is loaded, 
cpufreq governors cannot be started.
 
> You may want to make the sampling rate configurable at run time.

Such a "tweaking by sysfs" patch can be added later.

	Dominik
