Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWBOWKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWBOWKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWBOWKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:10:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39696 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751316AbWBOWKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:10:47 -0500
Date: Wed, 15 Feb 2006 23:10:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andrew Morton <akpm@osdl.org>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: 2.6.16-rc3-mm1: ISDN_DRV_GIGASET driver
Message-ID: <20060215221046.GC5066@stusta.de>
References: <20060214014157.59af972f.akpm@osdl.org> <20060214140019.GD10701@stusta.de> <43F28A6D.5080109@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F28A6D.5080109@imap.cc>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:57:01AM +0100, Tilman Schmidt wrote:

> Adrian,

Hi Tilman,

> thank you very much for taking the time to comment.
> 
> On 14.02.2006 15:00, you wrote:
> > - Do we really want to add new non-CAPI drivers to the kernel?
> 
> I have been in contact with the isdn4linux maintainer Karsten Keil on
> that topic for quite some time and he didn't voice any objections to
> submitting the driver in its current state.
> 
> Personally I am a great fan of CAPI, and of course we'll be happy to
> port the driver to CAPI as soon as the capi4linux / mISDN framework is
> ready for such an endeavour. This may however take some time yet, if I
> understand Karsten correctly. In particular, we are talking here about
> the mISDN L3 interface which seems to be the most appropriate for this
> purpose, but has not been documented so far.
> 
> In the meantime, I take it from the discussions on lkml that it is
> strongly discouraged to maintain working drivers outside the kernel
> tree, which is what prompted us to submit ours in the first place.
> Therefore I think it's in the best interest of everybody to merge its
> current isnd4linux gestalt now, and convert it to CAPI at the earliest
> convenience.

OK.

> > - A new driver that can only be built modular is not acceptable.
> 
> No problem. In fact, the submitted drivers work fine if linked directly
> into the kernel, too. The dependency on modular build in gigaset/Kconfig
> only exists for the benefit of the ser_gigaset driver which we didn't
> submit anyway. (See part 0 for the reasons.) We left it in because tests
> have been done almost exclusively with modular builds; but if that turns
> out to be a problem we'll just remove it.

All drivers in the kernel should work built statically into the kernel, 
and I don't see an obvious reason why your driver should work worse when 
being compiled statically into the kernel.

> Regards
> Tilman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

