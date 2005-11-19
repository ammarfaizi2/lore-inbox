Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVKSGXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKSGXf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 01:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVKSGXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 01:23:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750843AbVKSGXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 01:23:34 -0500
Date: Sat, 19 Nov 2005 01:23:32 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell_rbu driver depends on x86[64]
Message-ID: <20051119062332.GB7335@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051118212938.GB3881@redhat.com> <20051118220144.11671174.akpm@osdl.org> <20051119061459.GA7335@redhat.com> <20051118221744.2aa58499.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118221744.2aa58499.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 10:17:44PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Fri, Nov 18, 2005 at 10:01:44PM -0800, Andrew Morton wrote:
 > >  > Dave Jones <davej@redhat.com> wrote:
 > >  > >
 > >  > > This driver only appears on IA32 & EM64T boxes.
 > >  > > 
 > >  > > Signed-off-by: Dave Jones <davej@redhat.com>
 > >  > > 
 > >  > > --- linux-2.6.14/drivers/firmware/Kconfig~	2005-11-14 19:23:45.000000000 -0500
 > >  > > +++ linux-2.6.14/drivers/firmware/Kconfig	2005-11-14 19:24:18.000000000 -0500
 > >  > > @@ -60,6 +60,7 @@ config EFI_PCDP
 > >  > >  
 > >  > >  config DELL_RBU
 > >  > >  	tristate "BIOS update support for DELL systems via sysfs"
 > >  > > +	depends on X86
 > >  > >  	select FW_LOADER
 > >  > >  	help
 > >  > >  	 Say m if you want to have the option of updating the BIOS for your
 > >  > 
 > >  > Does it not compile on other architectures?  If it does, there's an
 > >  > argument for leaving it there, for compile coverage.
 > > 
 > > If this were a "only works on non-x86" driver, I'd agree, but
 > > x86 drivers probably get way more coverage than any arch already,
 > > so I don't we really gain much by having this available on
 > > archs that can't run it.
 > 
 > Where's the advantage in removing it from non-x86 builds?

One less pointless option showing up in configs.
Just like we don't have countless other arch-specific drivers showing
up under non-native archs. Why is this one different ?

		Dave

