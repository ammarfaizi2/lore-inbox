Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRKHVO1>; Thu, 8 Nov 2001 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRKHVOR>; Thu, 8 Nov 2001 16:14:17 -0500
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:17833 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278325AbRKHVN6>; Thu, 8 Nov 2001 16:13:58 -0500
Message-ID: <3BEAF454.61F5B095@home.com>
Date: Thu, 08 Nov 2001 16:08:36 -0500
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support
In-Reply-To: <200111082005.fA8K5GY63302@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin

Thanks much that really cleared it up for me.

John

"Justin T. Gibbs" wrote:

> >Hi
> >
> >I configuring the kernel, there is a option "Build adapter firmware with
> >Kernel build".
>
> There should be.  This comment has been in my distributed patches for
> Configure.help for some time:
>
> Build Adapter Firmware with Kernel Build
> CONFIG_AIC7XXX_BUILD_FIRMWARE
>   This option should only be enabled if you are modifying the
>   firmware source to the aic7xxx driver and wish to have the
>   generated firmware include files updated during a normal
>   kernel build.  The assembler for the firmware requires
>   lex and yacc or their equivalents, as well as the db v1
>   library.  You may have to install additional packages or
>   modify the assembler make file or the files it includes
>   if your build environment is different than that of the
>   author.
>
> I guess it didn't make it in with the rest of the 6.2.4 driver.
>
> >There is no help for this. It's obvious that it build
> >firmware but is it installed in the adapter automagically ???
>
> Firmware is always downloaded by the driver during card initialization.
> As noted above, only someone working on the firmware should need to
> recompile it.
>
> >I also wonder why the reset delay is 15000 Msec. It used to be 5000
> >Msec. I've usually set it to that without nasty results. I just wonder
> >what the reasoning is behind such a long delay.
>
> Some devices require it.  The default should be long enough to accomodate
> all configurations.  If you can use something shorter, feel free to
> reconfig your kernel that way.
>
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

