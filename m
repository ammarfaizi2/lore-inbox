Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVATQa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVATQa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVATQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:29:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262278AbVATQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:28:13 -0500
Date: Thu, 20 Jan 2005 17:28:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Chris Bruner <cryst@golden.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050120162807.GA3174@stusta.de>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:13:22AM +0100, Janos Farkas wrote:

> Hi Andi!
> 
> I had difficulties booting recent rc1-bkN kernels on at least two
> Athlon machines (but somehow, on an *old* Pentium laptop booted with the
> a very similar system just fine).
> 
> The kernel just hung very early, just after displaying "BIOS data check
> successful" by lilo (22.6.1).  Ctrl-Alt-Del worked to reboot, but
> nothing else was shown.
> 
> It is a similar experience to Chris Bruner's post here:
> > http://article.gmane.org/gmane.linux.kernel/271352
> 
> I also recall someone having similar problem with Opterons too, but
> can't find just now..
> 
> rc1-bk6 didn't boot, and thus I started checking revisions:
> rc1-bk3 did boot (as well as plain rc1)
> rc1-bk4 didn't boot
> rc1-bk7 booted *after* reverting the patch below:
> 
> > 4 days ak 1.2329.1.38 [PATCH] x86_64/i386: increase command line size
> > Enlarge i386/x86-64 kernel command line to 2k
> > This is useful when the kernel command line is used to pass other
> > information to initrds or installers.
> > On i386 it was duplicated for unknown reasons.
> > Signed-off-by: Andi Kleen
> > Signed-off-by: Andrew Morton
> > Signed-off-by: Linus Torvalds
> 
> While arguably it's not a completely scientific approach (no plain bk7,
> and no bk6 reverted was tested), I'm inclined to say this was my
> problem...
> 
> Isn't this define a lilo dependence?

AOL:
- lilo 22.6.1
- CONFIG_EDD=y
- 2.6.10-mm1 and 2.6.11-rc1 did boot
- 2.6.11-rc1-mm1 and 2.6.11-rc1-mm2 didn't boot
- 2.6.11-rc1-mm2 with this ChangeSet reverted boots.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

