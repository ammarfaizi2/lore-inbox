Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVKYVpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVKYVpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 16:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVKYVpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 16:45:49 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43936
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751482AbVKYVpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 16:45:49 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 15:45:31 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511232119.46383.rob@landley.net> <20051125194524.GA2164@elf.ucw.cz>
In-Reply-To: <20051125194524.GA2164@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251545.32343.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 13:45, Pavel Machek wrote:
> > Odd.
> >
> > The way the script works is it repeatedly calls "make miniconfig" to see
> > if removing each line makes a difference.  Judging by the output, it
> > thinks none of the lines it removed made any difference.
> >
> > Could you send me the .config you tried to shrink down?
>
> Here it is.
>
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.15-rc2
> # Wed Nov 23 14:17:02 2005
...

Uh-huh.

  landley@driftwood:~/linux-2.6.15-rc2$ make allnoconfig > /dev/null
  landley@driftwood:~/linux-2.6.15-rc2$ diff -u .config pavelconfig
  --- .config     2005-11-25 15:38:49.333425064 -0600
  +++ pavelconfig3        2005-11-25 15:41:40.929338520 -0600
  @@ -1,7 +1,7 @@
   #
   # Automatically generated make config: don't edit
  -# Linux kernel version: 2.6.15-rc2-git2
  -# Fri Nov 25 15:38:49 2005
  +# Linux kernel version: 2.6.15-rc2
  +# Wed Nov 23 14:17:02 2005
   #
   CONFIG_X86_32=y
   CONFIG_SEMAPHORE_SLEEPERS=y
  landley@driftwood:~/linux-2.6.15-rc2$ 
  
Am I wrong, or is the .config you just sent me identical to the output of 
allnoconfig?  (I have no idea why it decided CONFIG_PM=y was needed, I just 
reproduced that here.  Probably an idiosyncrasy of allnoconfig, I could 
investigate that...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
