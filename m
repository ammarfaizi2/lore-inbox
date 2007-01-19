Return-Path: <linux-kernel-owner+w=401wt.eu-S932813AbXASRgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbXASRgH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXASRgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:36:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2738 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932813AbXASRgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:36:06 -0500
Date: Fri, 19 Jan 2007 18:36:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
Message-ID: <20070119173612.GP9093@stusta.de>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6> <orzm8f9bvs.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orzm8f9bvs.fsf@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 03:15:03PM -0200, Alexandre Oliva wrote:
>...
> That's still a long way ahead (the 4.3 development cycle has just
> started), but it wouldn't hurt to start fixing incompatibilities
> sooner rather than later, and coming up with a clean and uniform set
> of inline macros that express intended meaning for the kernel to use.

I had already removed most of the "extern inline"s in the kernel since 
they give warnings with -Wmissing-prototypes (which I'd like to enable 
long-term in the kernel since it helps discovering a class of nasty 
runtime errors).

As far as I can see, all we need is "static inline" with the semantics
"force inlining" for functions in header files and perhaps a handful of 
functions in C files (if any).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

