Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290078AbSAKUCX>; Fri, 11 Jan 2002 15:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSAKUCJ>; Fri, 11 Jan 2002 15:02:09 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:34080 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290078AbSAKUCC> convert rfc822-to-8bit; Fri, 11 Jan 2002 15:02:02 -0500
Date: Fri, 11 Jan 2002 21:01:27 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andreas Boman <aboman@goofy.nerdfest.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 has 2 modules named sym53c8xx.o
In-Reply-To: <20020111000052.34204997.aboman@goofy.nerdfest.org>
Message-ID: <20020111204356.G1567-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jan 2002, Andreas Boman wrote:

> It seems a new sym53c8xx was added in 2.4.17, and now there are 2 modules,
> both named sym53c8xx.o (CONFIG_SCSI_SYM53C8XX and
> CONFIG_SCSI_SYM53C8XX_2). This was noticed since my mkinitrd script isn't
> smart enough to destinguish the two. Leading to the question how does
> modprobe? Comparing this with the naming scheme used for the two aic7xxx
> modules (aic7xxx.o and aic7xxx_old.o) it seems like its a bug to me, in
> either case I'd appritiate some input from somebody clued in on the issue.

This is a compatibility feature. Just select _the_ driver you want to use
but not both. The bug is to build the both drivers without special needs
or goal.

Renaming a driver object module will break compatibility of old linux
installations depending of the driver selected, and also may break
flexibility for who knows what he is doing.

By the way, if it ever happens one of the two modules to be renamed in
2.4, it is the old version that will be. As a result, the patch you sent
me directly that renames the new version is exactly what I donnot want to
be done.

In kernel 2.5, SYM53C8XX_2 will replace SYM53C8XX. I already agreed with
the proposal to remove the old driver version, and I suggested so
implicitely, obviously, by providing SYM53C8XX_2. I hope this will also
happen in 2.4 series, but probably a bit later.

  Gérard.

