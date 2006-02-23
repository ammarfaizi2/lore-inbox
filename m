Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWBWT7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWBWT7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWBWT7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:59:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35345 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751778AbWBWT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:59:39 -0500
Date: Thu, 23 Feb 2006 20:59:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Status of X86_P4_CLOCKMOD?
Message-ID: <20060223195937.GA5087@stusta.de>
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602212220.05642.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:20:04PM -0500, Dmitry Torokhov wrote:
> On Tuesday 21 February 2006 22:10, Adrian Bunk wrote:
> > On Wed, Feb 22, 2006 at 03:44:38AM +0100, Herbert Poetzl wrote:
> > > 
> > >  config X86_P4_CLOCKMOD
> > > 	depends on EMBEDDED
> > 
> > This one is an x86_64 only issue, and yes, it's wrong.
> 
> That's for P4, not X86_64... And since P4 clock modulation does not provide
> almost any energy savings it was "hidden" under embedded.

But the EMBEDDED dependency is only on x86_64:

arch/i386/kernel/cpu/cpufreq/Kconfig:
config X86_P4_CLOCKMOD
        tristate "Intel Pentium 4 clock modulation"
        select CPU_FREQ_TABLE
        help

arch/x86_64/kernel/cpufreq/Kconfig:
config X86_P4_CLOCKMOD
        tristate "Intel Pentium 4 clock modulation"
        depends on EMBEDDED
        help

And if the option is mostly useless, what is it good for?

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

