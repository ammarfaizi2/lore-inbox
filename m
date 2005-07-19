Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVGSV0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVGSV0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVGSV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:26:53 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:20497 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261645AbVGSV0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:26:52 -0400
Message-ID: <42DD7011.6080201@stud.feec.vutbr.cz>
Date: Tue, 19 Jul 2005 23:26:41 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de>
In-Reply-To: <42DD6AA7.40409@domdv.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> Michal Schmidt wrote:
>>Does resuming from swsuspend work for anyone with amd64-agp loaded?
>>
>>On my system when I suspend with amd64-agp loaded, I get a spontaneous
>>reboot on resume. It reboots immediately after reading the saved image
>>from disk.
>>This is 100% reproducible.
>>
>>Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.
> 
> 
> AMD Athlon(tm) 64 Processor 3000+, Acer Aspire
> 
> Linux gringo 2.6.13-rc3-gringo #36 Sun Jul 17 15:57:17 CEST 2005 x86_64
> unknown unknown GNU/Linux
> 
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> 
> swsusp works for me. Could it be mm, agp as a module or some speciality
                                        ^^^^^^^^^^^^^^^
                                 That seems to be the problem!
> of your hardware?

I have rebuilt agpgart and amd64-agp into the kernel and now it has 
resumed successfully for the first time. Thank you for the hint!

But I still wonder, why that makes a difference.

Michal
