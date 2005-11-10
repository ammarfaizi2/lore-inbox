Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKJNCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKJNCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKJNCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:02:34 -0500
Received: from webapps.arcom.com ([194.200.159.168]:46601 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1750776AbVKJNCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:02:34 -0500
Message-ID: <437344E0.9040502@cantab.net>
Date: Thu, 10 Nov 2005 13:02:24 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110120708.GG2401@elf.ucw.cz>
In-Reply-To: <20051110120708.GG2401@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2005 13:03:51.0796 (UTC) FILETIME=[3290CB40:01C5E5F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Ok, I got a little bit more forward.
> 
> I created entry like this:
>         {
>                 .mfr_id         = 0x00b0,
>                 .dev_id         = 0x00b0,
>                 .name           = "Collie hack",
>                 .uaddr          = {
>                         [0] = MTD_UADDR_UNNECESSARY,    /* x8 */
>                 },
>                 .DevSize        = SIZE_4MiB,
>                 .CmdSet         = P_ID_INTEL_EXT,
>                 .NumEraseRegions= 1,
>                 .regions        = {
>                         ERASEINFO(0x10000,8),
>                 }
> }
> 
> (Which is probably wrong, I just made up the data)

Shouldn't you get hold of the datasheet for the flash chips and fill in
this information correctly?

David Vrabel
