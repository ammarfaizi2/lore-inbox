Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSCSSTE>; Tue, 19 Mar 2002 13:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCSSSz>; Tue, 19 Mar 2002 13:18:55 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27893
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S287862AbSCSSSr>; Tue, 19 Mar 2002 13:18:47 -0500
Date: Tue, 19 Mar 2002 10:20:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
Message-ID: <20020319182003.GR2254@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203191716170.24700-100000@Expansa.sns.it> <3C9770C9.5000201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 06:09:29PM +0100, Martin Dalecki wrote:
> Luigi Genoni wrote:
> >HI,
> >
> >also with 2.5.7, as with 2.5.6, I have problems at boot.
> >I get the usual oops while initialising IDE.
> >
> >my ide controller is:
> >
> >00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> >[Master])
> >        Subsystem: Intel Corporation 82801AA IDE
> >        Flags: bus master, medium devsel, latency 0
> >        I/O ports at 2460 [size=16]
> >
> >unfortunatelly, I do not have even the time to write down oops message,
> >but eip is c0135068, but then I do not find a similar entry in system.map
> >
> >any hint
> 
> This device is behaving quite like the 440MX chipset
> I have myself I can't therefore the oops expect beeing caused
> by a trivial programming error in the actual ide driver.
> I don't see much pointer acces in piix.c code as well.
> 
> However you could eventually just try apply the following
> pseudo diff to piix.c and then try again:
> 
> - 
> { PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },
> + 
> { PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66 },
> 
> Replaceing PIIX_UDMA_33 with PIIX_UDMA_33 could be worth a try as well.
> 

replace what with what?
