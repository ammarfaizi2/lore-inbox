Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVGTJPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVGTJPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 05:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVGTJPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 05:15:21 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26059 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261449AbVGTJPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 05:15:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: amd64-agp vs. swsusp
Date: Wed, 20 Jul 2005 11:15:07 +0200
User-Agent: KMail/1.8.1
Cc: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz>
In-Reply-To: <42DD7011.6080201@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201115.08733.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 19 of July 2005 23:26, Michal Schmidt wrote:
> Andreas Steinmetz wrote:
> > Michal Schmidt wrote:
> >>Does resuming from swsuspend work for anyone with amd64-agp loaded?
> >>
> >>On my system when I suspend with amd64-agp loaded, I get a spontaneous
> >>reboot on resume. It reboots immediately after reading the saved image
> >>from disk.
> >>This is 100% reproducible.
> >>
> >>Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.
> > 
> > 
> > AMD Athlon(tm) 64 Processor 3000+, Acer Aspire
> > 
> > Linux gringo 2.6.13-rc3-gringo #36 Sun Jul 17 15:57:17 CEST 2005 x86_64
> > unknown unknown GNU/Linux
> > 
> > CONFIG_AGP=y
> > CONFIG_AGP_AMD64=y
> > 
> > swsusp works for me. Could it be mm, agp as a module or some speciality
>                                         ^^^^^^^^^^^^^^^
>                                  That seems to be the problem!
> > of your hardware?
> 
> I have rebuilt agpgart and amd64-agp into the kernel and now it has 
> resumed successfully for the first time. Thank you for the hint!
> 
> But I still wonder, why that makes a difference.

Before resume the module is not present.  When it gets loaded from the
image it probably runs with the assumption that the hardware was initialized
which is not correct.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
