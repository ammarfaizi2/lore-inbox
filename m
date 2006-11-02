Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752710AbWKBVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWKBVvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:51:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40468 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752711AbWKBVvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:51:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EoWllS/ZbCLyRYZNHcp+KAg5UGDuRxKiQ8/V26QGXTXu+x+v3jdGJNHmPW8UFsmpUP5TnLKX5g8dO5G1qECcd3DdeOTPCnmMSRsJIiVjqjtIyC/YmjHb/LziKiFIt+CqWGvRHrwtF+wMlqGrM+X9wDyAyFxv2fi4QW0UWhu7CAU=
Message-ID: <b637ec0b0611021350q16d3c2e0h43b366a550497579@mail.gmail.com>
Date: Thu, 2 Nov 2006 22:50:58 +0100
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>
Subject: Re: [2.6.19-rc2-mm2] oops removing sd card
Cc: "Alex Dubov" <oakad@yahoo.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <4544725E.4050107@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
	 <4544725E.4050107@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. After some testing I found something interesting: in vanilla
2.6.19-rc4 - tifm works (I mean "removing the SD card from the
FlashMedia controller does not oops")

So, as I'm pretty sure 2.6.18-mm3 didn't trigger the oops, the cause
is in something between 2.6.18-mm3 and 2.6.19-rc2-mm2.

However, the driver does not survive a suspend-to-disk cycle; I will
open another thread for this.

Regards,
Fabio



On 10/29/06, Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
> Alex Dubov wrote:
> > I know that this is unfortunate, but I, currently, don't have an ability to put 2.6.19 kernel on a
> > machine with ti controller. I have not seen this problem on 2.6.18, so I'm out of ideas.
> >
>
> So put together some patches that will help you figure out the problem
> via Fabio. Tracking an oops isn't usually that difficult (it's usually
> some bogus pointer somewhere). Just sprinkle BUG_ON():s and printk:s all
> over the place until you can pinpoint the offending pointer.
>
> Rgds
> --
>      -- Pierre Ossman
>
>   Linux kernel, MMC maintainer        http://www.kernel.org
>   PulseAudio, core developer          http://pulseaudio.org
>   rdesktop, core developer          http://www.rdesktop.org
>
