Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSFNAuA>; Thu, 13 Jun 2002 20:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317863AbSFNAt7>; Thu, 13 Jun 2002 20:49:59 -0400
Received: from ns.suse.de ([213.95.15.193]:20748 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317862AbSFNAt6>;
	Thu, 13 Jun 2002 20:49:58 -0400
Date: Fri, 14 Jun 2002 02:45:47 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614024547.H16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 08:13:26PM -0400, James Bottomley wrote:
 > > Would it make sense for the subarchs to use the generic code where
 > > possible, and only reimplement it's own (for eg) apic.c as and when it
 > > actually *needs* to be different ? 
 > That is really the way I've implemented it.

Ah, good.

 >  The only PC specific file in the 
 > generic directory is mpparse.c (since neither visws nor voyager has an MP 
 > compliant bios).  All the shareable files are kept in `kernel' and activated 
 > by config options.

Another piece of low hanging fruit is probably dmi_scan.c
There are no workarounds there for either (are they even DMI compliant?)
so compiling it in doesn't make much sense.

 > I can certainly move mpparse.c back to kernel and add an extra (non user 
 > visible) config option.

if neither visws or voyager need it, I'd say it doesn't belong in the
respective subarch directories period.

 > > Sounds quite logical. What does the current patches you have do ? I've
 > > not had chance to look at them yet. 
 > It creates directories `generic' for the standard pc and `visws'.  The voyager 
 > patch creates a `voyager' directory.  Alternatively, these could be `mach-pc', 
 > `mach-visws' and `mach-voyager'.

Yeah, I think mach-foo would be more aesthetically pleasing, so I'll
cast my vote for that one. If nothing else, it makes it obvious that
the subdir isn't important if you don't care about $subarch

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
