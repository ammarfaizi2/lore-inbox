Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVATEV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVATEV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVATEV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:21:27 -0500
Received: from smtp.golden.net ([199.166.210.31]:12302 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S262043AbVATEVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:21:21 -0500
From: Chris Bruner <cryst@golden.net>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Date: Wed, 19 Jan 2005 23:21:16 -0500
User-Agent: KMail/1.7.2
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
In-Reply-To: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501192321.16473.cryst@golden.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I found that the problem I was having was caused by the "BIOS Enhanced 
Disk Drives" turned on.   It was on in previous versions as well, and they 
worked ok, so I assume that something has changed. In anycase turning it off 
fixed my problem.

Chris Bruner

On Wed January 19 2005 06:13 pm, Janos Farkas wrote:
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
>
> rc1-bk7 booted *after* reverting the patch below:
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

-- 
   I say, if your knees aren't green by the end of the day, you ought to
seriously re-examine your life.  -- Calvin
