Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSGNPtb>; Sun, 14 Jul 2002 11:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSGNPta>; Sun, 14 Jul 2002 11:49:30 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:64209 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316899AbSGNPt3>; Sun, 14 Jul 2002 11:49:29 -0400
Date: Sun, 14 Jul 2002 17:50:25 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Peter Osterlund <petero2@telia.com>
Cc: zwane@linuxpower.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
Message-ID: <20020714175025.A765@brodo.de>
References: <1026611437.13885.37.camel@irongate.swansea.linux.org.uk> <m265zj9zxn.fsf@best.localdomain> <6010.1026651788@www53.gmx.net> <20020714150912.A1148@brodo.de> <m2k7nyqqud.fsf@best.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <m2k7nyqqud.fsf@best.localdomain>; from petero2@telia.com on Sun, Jul 14, 2002 at 05:19:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 05:19:54PM +0200, Peter Osterlund wrote:
> Dominik Brodowski <devel@brodo.de> writes:
> 
> I tried speedstep but it didn't work because of this check in
> speedstep_detect_processor:
> 
> 		/* Intel Pentium 4 Mobile P4-M */
> 		if (c->x86_model != 2)
> 			return 0;
> 
> 		if (c->x86_mask != 4)
> 			return 0;     /* all those seem to support Enhanced
> 					 SpeedStep */
> 
> My cpu has model == 1 and mask == 2.
Strange: According to the Intel docs (24919923.pdf and 25072104.pdf) as of
June 2002, all P4-Ms have models have model "2" and mask "4", and none have
model "1" and mask "2". What does /proc/cpuinfo say? And are you really sure
it is a speedstep-capable P4-M?

I'm really doubtful of that, as the MSR_EBC_FREQUENCY_ID didn't change a bit
while trying speedstep transitions:

>         cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x8a01fe00 0x0
<snip>
>         cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x8a01fe00 0x0


>         cpufreq: currently at low speed setting - 13800 MHz
Obviously, this value is bogus, what's the correct CPU frequency of your
notebook?

> So what can I do to make speedstep work? According to the notebook
> manual, speedstep is supported on this computer.
How old is it? Fresh-out-of-the-factory? Then there might, just might be
some update to the P4 specifications not yet included in the documentation.
And please send me a /proc/cpuinfo, just to make sure. And, BTW, have you
tried ACPI and its "performance state" interface?

Dominik
