Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424098AbWKKLZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424098AbWKKLZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424347AbWKKLZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:25:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34318 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424098AbWKKLZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:25:26 -0500
Date: Sat, 11 Nov 2006 12:25:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: where can I select INPUT?
Message-ID: <20061111112528.GY4729@stusta.de>
References: <200611111325.02749.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111325.02749.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 01:24:58PM +0300, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Neither in menuconfig nor in xconfig do I see any place to actually select 
> INPUT. Help text suggests that it is a) selectable b) it can be made modules. 
> I do not have either option. Here what I see in menuconfig if I go into Input 
> device support:
> 
>     --- Generic input layer (needed for keyboard, mouse, ...)
>     < >   Support for memoryless force-feedback devices
>     ---   Userland interfaces
> 
> as you see there is no check box for INPUT itself.
> 
> I already had similar issue something else (I believe it was something related 
> to serio). In menuconfig item was no selectable, but I could directly 
> edit .config to change y to m.
>...

INPUT can only be unset if you set CONFIG_EMBEDDED=y.

The rationale is that it usually doesn't make sense for users to disable 
INPUT, and allowing it tends to cause some confusion.

> - -andrey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

