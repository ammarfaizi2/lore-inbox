Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVHADuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVHADuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 23:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVHADuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 23:50:13 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:781 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262031AbVHADuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 23:50:10 -0400
Date: Sun, 31 Jul 2005 23:49:41 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801034940.GC24130@mail>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	James Bruce <bruce@andrew.cmu.edu>,
	Lee Revell <rlrevell@joe-job.com>,
	Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
References: <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <20050731220754.GE7362@voodoo> <20050731223616.GB27580@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731223616.GB27580@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/05 12:36:16AM +0200, Pavel Machek wrote:
> > If the kernel defaults are irrelevant, then it would make more sense to
> > leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
> > order to keep with the principle of least surprise for people who do use
> > kernel.org kernels.
> 
> Well, I'd say you want ACPI enabled. New machine do not even boot
> without that. Default config should be usefull; set ACPI off, and
> you'll not be able to even power machine down.

And there are older machines that won't boot with it enabled. The machine
I'm typing this on has a really shitty ACPI implementation, I don't remember
the details because it's been so long but I know that I have to disable ACPI 
for it to work right.

I'm not saying defconfig should never be changed, but changing what can and
will cause noticeable breakage should be avoided if possible. And in this
case it doesn't seem to me that the benefits of changing HZ in the middle
of a "stable" series outweigh the added latency.

> 								Pavel

Jim.
