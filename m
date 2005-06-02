Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVFBOOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFBOOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVFBOOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:14:00 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:3847 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261357AbVFBON5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:13:57 -0400
Message-ID: <429F141E.8030409@stud.feec.vutbr.cz>
Date: Thu, 02 Jun 2005 16:13:50 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFB66.8030909@stud.feec.vutbr.cz> <20050602123927.GB10878@elte.hu>
In-Reply-To: <20050602123927.GB10878@elte.hu>
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
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>>Nonetheless the latency tracing still doesn't work for me on x86_64. 
>>It compiles but hotplug starts to segfault in an infinite loop during 
>>booting up. When I disable CONFIG_LATENCY_TRACE, it works.
> 
> 
> hm, it does work for me. I had trouble in the past with gcc & mcount on 
> x64. This version seems to work fine for me:
> 
>  gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)

I have:
gcc (GCC) 3.4.4 20050314 (prerelease) (Debian 3.4.3-13.0.0.1.gcc4)
I have also tried with:
gcc-3.3 (GCC) 3.3.5 (Debian 1:3.3.5-12.0.0.1.gcc4)
It made no difference.
Maybe I'll try vanilla GCC 3.4.4.

> also, could you try disabling hotplug (and module support too)? Maybe 
> something in that area breaks.

OK, I'll try to minimise my .config.

> I've attached a .config that works for me.
> [...]
> # CONFIG_LATENCY_TRACE is not set

Are you sure this is the right .config?

Michal
