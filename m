Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVAIAXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVAIAXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVAIAXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:23:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60939 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262157AbVAIAW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:22:58 -0500
Date: Sun, 9 Jan 2005 01:22:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] always enable regparm on i386
Message-ID: <20050109002253.GJ14108@stusta.de>
References: <20050108205049.GR14108@stusta.de> <20050108155248.25393222.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108155248.25393222.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 03:52:48PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > The patch below always enables regparm on i386 (with gcc >= 3.0).
> > 
> >  With this patch, it should get a better testing coverage in -mm.
> > 
> >  If this doesn't cause any problems, I plan to send a patch to completely 
> >  remove the CONFIG_REGPARM option after 2.6.11 will be released.
> 
> -mregparm has revealed at least two kernel bugs thus far.  The ability to
> disable -mregparm is a useful diagnostic tool.

You are still able to disable it by editing the Kconfig file.

And even if the option will no longer be present at some time in the 
future, it will be trivial to disable it in the Makefile.

But currently (an option depending on EXPERIMENTAL) the testing coverage 
isn't that big, and with this -mm patch, most people using -mm [1] will 
have it enabled and notice if other problems pop up.

cu
Adrian

[1] except for those with gcc < 3.0 or !i386

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

