Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUKIAoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUKIAoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKIAo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:44:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48648 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261341AbUKIAoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:44:14 -0500
Date: Tue, 9 Nov 2004 01:43:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] drivers/media/video/ cleanups
Message-ID: <20041109004341.GO15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108114008.GB20607@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:40:08PM +0100, Gerd Knorr wrote:
> On Sun, Nov 07, 2004 at 06:50:17PM +0100, Adrian Bunk wrote:
> > the patch below contains several cleanups for drivers/media/video/, most 
> > of them are:
> > - needlessly global code made static
> > - currenly unused code removed
> 
> No, not this way in one big blob please.  It would be very nice if you
> can split that into smaller pieces:
> 
>   (1) The ObviouslyCorrect stuff, i.e. make stuff static which isn't
>       declared in any header file.
>   (2) The stuff which needs some more careful review (drop functions,
>       drop stuff from header files, ...).
> 
> Especially the later please splitted by driver, so the driver
> maintainers can have a look (which is kida problematic for some v4l
> drivers as there is no active maintainer currently, but I'd prefeare
> to have that separately in my inbox neverless).

OK, the patches follow as followups to this mail.

> I don't like your attitude to just drop stuff as "cleanup".  If
> functions are declared in a header file they are usually for a reason,
> thus that kind of stuff needs some careful checking whenever these
> reasons still exist or not.  Not every function which isn't used at the

That's why I prefixed the subject with "RFC"...

> moment automatically is useless.  cx88_risc_disasm() for example is
> useful for debugging the driver.  And that there is no in-kernel user

But couldn't this be #if 0'ed?

This way it was easily available for developers, but wouldn't use space 
for all users.

> for exported functions doesn't mean that nobody uses it.  The stuff
> exported by bttv-if is used by lirc for example.

I've removed the bttv-if changes from the patches.

BTW: Can't lirc be included in the main kernel?

>   Gerd

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

