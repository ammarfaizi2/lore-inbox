Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJPTAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJPTAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJPTAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:00:24 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48970 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261239AbUJPTAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:00:22 -0400
Date: Sat, 16 Oct 2004 23:00:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041016210024.GB8306@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164DAC9.8080701@kegel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 10:57:29PM -0700, Dan Kegel wrote:
> Sam Ravnborg wrote:
> >On Tue, Sep 21, 2004 at 10:40:24PM -0700, Dan Kegel wrote:
> >>    683    2328   27265 linux-2.6.8-build_on_case_insensitive_fs-1.patch
> >>     28     122    1028 linux-2.6.8-noshared-kconfig.patch
> >
> >Can you please post these two patches.
> >The fist I hope is very small today.
> 
> OK, here they are, plus a third one that also seems neccessary:
> 
> This one's by Martin Schaffner:
> http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-build_on_case_insensitive_fs.patch
> 
Most of this is done in current linus-BK. I'm planning to handle
asm-offset in another way and will then start to get rid of .S -> .s

> This one's by Kevin Hilman.  I haven't tried it yet, but seems neccessary:
> http://www.kegel.com/crosstool/linux-2.6.8-netfilter-case-insensitive.patch
> 
This should be taken with the netfilter people.

> Both of the above choose arbitrary ways to avoid using
> filenames identical but for case.  Feel free to pick
> some other way, there's nothing magic about the names we picked.
> 
> This one's after an idea by bertrand.marquis@sysgo.com,
> but it's small enough to be considered trivial.  Many OS's
> don't support shared libraries as easily as Linux does,
> and there's nothing to be gained by making libkconfig shared, so don't.
> http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-noshared-kconfig.patch
> 

I will give this a try - and apply if I see no problems.

	Sam
