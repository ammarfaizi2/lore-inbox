Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272541AbTHEQPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272546AbTHEQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:15:39 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:40867 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272541AbTHEQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:15:26 -0400
Date: Tue, 5 Aug 2003 18:15:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Ducrot Bruno <poup@poupinou.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805161505.GD18982@louise.pinerecords.com>
References: <20030805072631.GC5876@louise.pinerecords.com> <20030805161117.GA1511@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805161117.GA1511@poupinou.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [poup@poupinou.org]
> 
> I don't understand this chunk:
> 
> > diff -urN a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
> > --- a/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-10 23:30:33.000000000 +0200
> > +++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-27 13:50:30.000000000 +0200
> > @@ -2,10 +2,9 @@
> >  # CPU Frequency scaling
> >  #
> >  
> > -menu "CPU Frequency scaling"
> > -
> >  config CPU_FREQ
> >  	bool "CPU Frequency scaling"
> > +	depends on PM
> >  	help
> >  	  Clock scaling allows you to change the clock speed of CPUs on the
> >  	  fly. This is a nice method to save battery power on notebooks,
> > @@ -16,6 +15,8 @@
> >  
> >  	  If in doubt, say N.
> >  
> > +if CPU_FREQ
> > +
> >  source "drivers/cpufreq/Kconfig"
> >  
> >  config CPU_FREQ_TABLE
> > @@ -162,4 +163,4 @@
> >  
> >  	  If in doubt, say N.
> >  
> > -endmenu
> > +endif

o  only enable cpufreq options if power management is selected
o  don't put cpufreq options in a separate submenu

-- 
Tomas Szepe <szepe@pinerecords.com>
