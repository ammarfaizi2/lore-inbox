Return-Path: <linux-kernel-owner+w=401wt.eu-S1754914AbXABV4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbXABV4Y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbXABV4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:56:24 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3963 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753665AbXABV4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:56:23 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Tue, 2 Jan 2007 21:56:48 +0000
User-Agent: KMail/1.9.5
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200612311655.51928.s0348365@sms.ed.ac.uk> <20070102211045.GY20714@stusta.de>
In-Reply-To: <20070102211045.GY20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701022156.48919.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 January 2007 21:10, Adrian Bunk wrote:
[snip]
> > > Comparing your report and [1], it seems that if these are the same
> > > problem, it's not a hardware bug but a gcc or kernel bug.
> >
> > This bug specifically indicates some kind of miscompilation in a driver,
> > causing boot time hangs. My problem is quite different, and more subtle.
> > The crash happens in the same place every time, which does suggest
> > determinism (even with various options toggled on and off, and a 300K
> > smaller kernel image), but it takes 8-12 hours to manifest and only
> > happens with GCC 4.1.1. ...
>
> Sorry if my point goes a bit away from your problem:
>
> My point is that we have several reported problems only visible
> with gcc 4.1.
>
> Other bug reports are e.g. [2] and [3], but they are only present with
> using gcc 4.1 _and_ using -Os.

I find [2] most compelling, and I can confirm that I do have the same problem 
with or without optimisation for size. I don't use selinux nor has it ever 
been enabled.

At any rate, I have absolute confirmation that it is GCC 4.1.1, because with 
GCC 3.4.6 the same kernel I reported booting three days ago is still 
cheerfully working. I regularly get uptimes of 60+ days on that machine, 
rebooting only for kernel upgrades. 2.6.19 seems to be no worse in this 
regard.

Perhaps fortunately, the configs I've tried have consistently failed to shake 
the crash, so I have a semi-reproducible test case here on C3-2 hardware if 
somebody wants to investigate the problem (though it still takes 6-12 hours).

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
