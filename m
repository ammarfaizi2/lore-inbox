Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGBVPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGBVPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWGBVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:15:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20404 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750743AbWGBVPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:15:31 -0400
Date: Sun, 2 Jul 2006 23:15:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
In-Reply-To: <1151840308.3111.14.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0607022313550.5218@yvahk01.tjqt.qr>
References: <44A7AADB.8040106@xs4all.nl>  <1151839268.3111.10.camel@laptopd505.fenrus.org>
  <44A7ACF2.4070304@xs4all.nl> <1151840308.3111.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Hi,
>> > 
>> > something really bad happened (the processor jumped into hyperspace);
>> > however it looks like automatic symbol resolving isn't working;
>> > could you check if CONFIG_KALLSYMS is enabled in your kernel config?
>> > With that enabled, debugability tends to go up bigtime since at least
>> > the backtrace becomes human readable...
>> 
>> I have:
>> 
>> CONFIG_KALLSYMS=y
>
>Hoi,
>
>hmmmmm then something really bad happened, so bad that even the
>backtrace is corrupted ;(

How about adding this one?
	CONFIG_FRAME_POINTER=y
Compiling things without frame pointer on 
userspace (yes, userspace) makes debugging impossible, I wonder how the 
kernel can do it without FPs.
And if you got time on your hands
	CONFIG_UNWIND_INFO=y


Jan Engelhardt
-- 
