Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWIWWdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWIWWdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIWWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:33:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50447 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750731AbWIWWdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:33:53 -0400
Date: Sun, 24 Sep 2006 00:33:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923223348.GH5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923224909.69579243.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923224909.69579243.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 10:49:09PM +0200, Jean Delvare wrote:

> Hi Adrian, Greg,

Hi Jean,

> I second Greg's objection, and share his worries. "No possible
> regression" is something extremely hard to evaluate in general.
> Besides, the goal of -stable as I remember it is not "no regression"
> but rather "only bugfixes", i.e. patches don't go in without a good
> reason (default policy = reject), rather than patches are rejected if
> they may cause problem (default policy = accept.)
> 
> Adding support for new devices, even if it's only adding an ID in a
> list, is not always safe. I am not happy about new IDs being considered
> as OK for late RCs, I am even less so for -stable.

the main goals for 2.6.16 are:
- no regressions
- security fixes

And I did always say that things like adding new PCI IDs are considered 
OK for 2.6.16.

> The sole fact that Adrian felt the need to release a -pre1 for
> 2.6.16.30 betrays his lack of confidence IMHO.

No, all it says is:
- there was no reason for releasing 2.6.16.30 very soon
- my TODO list still contains reviewing 65 of the patches the -stable
  team added to 2.6.17

> And the size of ChangeLog-2.6.16.29 speaks for itself.

Except for 2 bug fixes, all of them were patches the -stable team added 
to 2.6.17.

> Given that 2.6.16.y follows the naming convention of -stable and is
> released in the official v2.6 directory on ftp.kernel.org, I'd like to
> see it follow the same rules we have for "real" -stable trees. Adrian,
> if you are going to diverge from the original intent of -stable, this
> is your own right, but then please change the name of your tree to
> 2.6.16-ab or something similar, to clear the confusion.
> 
> I will not use 2.6.16.y with its current rules, for sure, and I doubt
> any distribution will. Wasn't the whole point of 2.6.16.y to serve as a
> common base between several distributions?

No, see [1]:

<--  snip  -->

Q:
What is the target audience for this 2.6.16 series?

A:
The target audience are users still using 2.4 (or who'd still use kernel 
2.4 if they weren't forced to upgrade to 2.6 for some reason) who want a 
stable kernel series including security fixes but excluding many 
regressions.
It might also be interesting for distributions that prefer stability 
over always using the latest stuff.

<--  snip  -->


The 2.6.16 series is an offer.

If you don't want to use it it's OK.

Distributions can use it, cherry pick from it, or ignore it.

Whether a distribution uses 2.6.16 or a more recent kernel (that will 
anyway support more hardware than 2.6.16 ever will), and if a 
distribution that uses 2.6.16 will ever follow the 2.6.16 series depends 
on the goals of the distribution.


> Thanks,
> Jean Delvare

cu
Adrian

[1] http://article.gmane.org/gmane.linux.kernel/354360

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

