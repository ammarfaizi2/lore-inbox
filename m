Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVKBMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVKBMlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVKBMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:41:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28168 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932671AbVKBMlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:41:07 -0500
Date: Wed, 2 Nov 2005 13:29:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
Message-ID: <20051102122950.GB15515@alpha.home.local>
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet> <4367C95D.3050108@drugphish.ch> <20051102002821.GC13557@alpha.home.local> <43689CCF.1060102@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43689CCF.1060102@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto,

On Wed, Nov 02, 2005 at 12:02:39PM +0100, Roberto Nibali wrote:
> Bonjour Willy,
> 
> >>Willy, if you have time, could you check your non-i386 boxes with a
> >>2.95.x compiled 2.4.x kernel, with IPVS enabled?
> >  
> > Yes, no problem, but you'll have to tell me what to test ! (a config
> > or script will save me some time). I have a Sun Ultra60 (ultrasparc SMP)
> > which matches your description. I just have a doubt about gcc-2.95
> > availability on this box, I know I have a 3.3.6, do you think that the
> > problem is gcc-related (too strong optimization or de-inlining, etc) ?
> 
> At least following should be set, the rest you can leave to your gusto:
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_MMCONFIG=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SYSTEM=y

But this is purely x86-related, I won't have it on sparc.

> CONFIG_IP_VS=m
> CONFIG_IP_VS_DEBUG=y
> CONFIG_IP_VS_TAB_BITS=12
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> CONFIG_IP_VS_HPRIO=m
> CONFIG_IP_VS_FTP=m
> 
> One issue is a possible C99'ism in the last IPVS patch. If you find
> time, please have a 2.95.x compiler installed.

You mean that it's a build issue ? I first thought that you got erroneous
behaviour.

> Another thing that could fail is if you additionally set
> 
> CONFIG_ACPI_FAN=m
> 
> and compile with CFLAGS="-g -ggdb"

will test too

> > Please keep us informed when you have more info.
> 
> I will, and I will get more details, as time permits. My beef with the
> IPVS code seems to be wrong, the code works as expected so far. I'm
> stress-testing it though until Sunday on a 4GB Dual P4 Xeon with HT combo.

How could I stress it ? what ipvs config, what type of traffic ? I'm used
to stress-test firewalls and load-balancers, but there is a wide choice of
possibilities, and all cannot be explored in a short timeframe.

Regards,
Willy

