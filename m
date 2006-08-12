Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWHLQYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWHLQYu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWHLQYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:24:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38663 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932475AbWHLQYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:24:49 -0400
Date: Sat, 12 Aug 2006 18:24:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Pavel Machek <pavel@suse.cz>,
       Josh Boyer <jwboyer@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060812162447.GE5084@stusta.de>
References: <200608091749_MC3-1-C796-5E8D@compuserve.com> <20060809220048.GE3691@stusta.de> <44DB1F19.8000504@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DB1F19.8000504@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 01:57:13PM +0200, Stefan Richter wrote:
> Adrian Bunk wrote:
> ...
> > I'm currently 
> > going through all 2.6.17.7 and 2.6.17.8 patches looking for patches I 
> > should apply.
> 
> Suggested updates for drivers/ieee1394/:
> 
> (from 2.6.17.2)
>   Fix broken suspend/resume in ohci1394
> should be applicable as-is. This does not add full suspend/resume
> functionality to ohci1394 but it fixes fatal side effects on other
> on-board hardware after resume.
> 
> (from 2.6.17.8)
>   ieee1394: sbp2: enable auto spin-up for Maxtor disks
> doesn't apply to 2.6.16 as-is.
> https://bugzilla.novell.com/show_bug.cgi?id=183011#c6 has an adapted
> version. I will mail it to you with proper description and signed-off-by
> later today. While I am at it, I will resend that ohci1394 patch too.

Thanks, I've applied them both.

> I have a related question about your plans with Linux 2.6.16.yy.
> Documentation/stable_kernel_rules.txt says:
> 
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short,
>    something critical.
> 
> I plan to submit a patch of the kind "fix recognition of a quirky
> device" for 2.6.18. That patch does not fix an oops, hang, data
> corruption, or security hole. (The patch will fulfill all other criteria
> from stable_kernel_rules.) Do you consider "can't use that shiny device
> under Linux" as "oh, that's not good" in the context of Linux 2.6.16.yy?
>...

If the device doesn't work, it's an "oh, that's not good" issue. ;-)

More seriously:

I consider stable_kernel_rules.txt as a more formal description of
"avoid regressions".

If the patch is tested, unlikely to break anything and included in 
Linus' tree it's a candidate for 2.6.16.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

