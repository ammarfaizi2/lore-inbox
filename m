Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbSAGBcF>; Sun, 6 Jan 2002 20:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSAGBbz>; Sun, 6 Jan 2002 20:31:55 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20644 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286261AbSAGBbv>; Sun, 6 Jan 2002 20:31:51 -0500
Date: Sun, 6 Jan 2002 18:31:53 -0700
Message-Id: <200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <3C38BD32.6000900@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
	<3C38BC6B.7090301@zytor.com>
	<200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>
	<3C38BD32.6000900@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> 
> > H. Peter Anvin writes:
> > 
> >>Once again, this shit does not belong in N drivers; it is core code.
> >>
> > 
> > Drivers have to register their own device nodes. What kind of API do
> > you propose?
> 
> The existence of a CPU creates /dev/cpu/# and registering a node 
> replicates across the /dev/cpu directories.

So you mean something like this:

void devfs_per_cpu_register (const char *leafname, unsigned int flags,
			     unsigned int major, unsigned int minor_start,
			     umode_t mode, void *ops);

void devfs_per_cpu_unregister (const char *leafname);

with code in the per-cpu boot code to create the /dev/cpu/%d
directories.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
