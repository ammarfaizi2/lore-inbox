Return-Path: <linux-kernel-owner+w=401wt.eu-S1161140AbXAEQT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbXAEQT3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbXAEQT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:19:29 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1888 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161140AbXAEQT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:19:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Fri, 5 Jan 2007 16:19:54 +0000
User-Agent: KMail/1.9.5
Cc: Mikael Pettersson <mikpe@it.uu.se>, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <200701051553.04673.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701050757320.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701050757320.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051619.54977.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 16:02, Linus Torvalds wrote:
> On Fri, 5 Jan 2007, Alistair John Strachan wrote:
> > This didn't help. After about 14 hours, the machine crashed again.
> >
> > cmov is not the culprit.
>
> Ok. Have you ever tried to limit the drivers you have loaded? I notice you
> had the prism54 wireless thing in your modules list and the vt1211 hw
> monitoring thing. I'm wondering about the vt1211 thing - it probably isn't
> too common.

Sure, and it only got added to 2.6.19 anyway (however GCC 3.4.6 really does 
seem to have no problem with it).

> But if you can use that machine without the wireless too, it
> might be good to try without either.

Required, plus I've been running prism54 on three different machines with a 
huge number of compilers since the early 2.6 days with no problems.

> (The rest of your module list looked bog-standard, so if it's not
> hardware-specific, I don't think it's there)

Agreed, the config is already _very_ minimal for this machine.

> Turning of the VIA sound driver just in case would be good too.

I'm not even really sure why that's enabled. I can do that.

> The reason I mention vt1211 in particular is that it does things like
> regulate fan activity etc. Is the problem perhaps heat-related?

It definitely isn't heat related. This CPU puts out 7-10W, has a ridiculous 
5000 RPM fan on it (that works) and the temp never exceeds 40C. If anything, 
the -O2, 3.4.6 kernel with CMOV ran the chip a little hotter.

As far as I can see, all the other components are either cool to touch or have 
stupidly big heatsinks on them.

(I realise with problems like these it's almost always some sort of obscure 
hardware problem, but I find that very difficult to believe when I can toggle 
from 3 years of stability to 6-18 hours crashing by switching compiler. I've 
also ran extensive stability test programs on the hardware with absolutely no 
negative results.)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
