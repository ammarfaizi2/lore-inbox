Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTAHAGD>; Tue, 7 Jan 2003 19:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267646AbTAHAGD>; Tue, 7 Jan 2003 19:06:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46852 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267605AbTAHAGD>; Tue, 7 Jan 2003 19:06:03 -0500
Date: Wed, 8 Jan 2003 00:14:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030108001436.A14505@flint.arm.linux.org.uk>
Mail-Followup-To: Robert Love <rml@tech9.net>, Adrian Bunk <bunk@fs.tum.de>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301011435300.27623-100000@dell> <20030107233012.GP6626@fs.tum.de> <1041982936.694.786.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041982936.694.786.camel@phantasy>; from rml@tech9.net on Tue, Jan 07, 2003 at 06:42:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 06:42:16PM -0500, Robert Love wrote:
> On Tue, 2003-01-07 at 18:30, Adrian Bunk wrote:
> > Robert, could you comment on whether it's really needed to have the 
> > preemt option defined architecture-dependant?
> > 
> > After looking through the arch/*/Kconfig files it seems to me that the
> > most problematic things might be architecture-specific parts of other
> > architecturs that don't even offer PREEMPT and the depends on CPU_32 in
> > arch/arm/Kconfig.
> 
> I think it should be there.  Plus, as you say, it is defined
> per-architecture.
> 
> The real problem in my opinion is that the category is misnamed.  It is
> not "processor options" except for the first couple.  The majority of
> the options should be under a title of "core" or "architecture" or
> "system options" in my opinion.

On ARM, it doesn't appear under "processor options" but under
"General Setup", which is where it fits best, along with the other
general core features of the kernel.  It does depend on a processor
option, but there should not be any problem with that.  ARM _does
not_ support preempt on 26-bit ARM CPUs, so we _explicitly_ disallow
selection of that configuration.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

