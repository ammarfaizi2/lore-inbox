Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTARB6v>; Fri, 17 Jan 2003 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTARB6u>; Fri, 17 Jan 2003 20:58:50 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:39951 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261900AbTARB6u>; Fri, 17 Jan 2003 20:58:50 -0500
Message-ID: <3E28B099.4E85C56D@linux-m68k.org>
Date: Sat, 18 Jan 2003 02:40:41 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: questions about config files, I2C and hardware sensors (2.5.59)
References: <Pine.LNX.4.44.0301170636120.13098-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Robert P. J. Day" wrote:

>   so the issues:
> 
> 1) trivial: comment is wrong, there is no dependency on
>    EXPERIMENTAL

This has to be answered by the I2C maintainer.

> 2) since, in the sourcing Kconfig file, I2C_PROC *already* depends
>    on I2C, is there any practical value in having the dependency
>    "I2C && I2C_PROC".  wouldn't "depends on I2C_PROC" be sufficient?

Yes.

> 3) finally, given that the comment at the top is adamant that
>    all of these options depend on I2C and I2C_PROC, wouldn't it
>    be cleaner to just make the menu itself say:
> 
>    menu "I2C HW Sensors Mainboard Support"
>         depends on I2C && I2C_PROC              (or just I2C_PROC)
>         ...
> 
>    and let the internal options inherit this dependency?

Yes, the menu entry needs the dependencies as well.

bye, Roman

