Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTGKS7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbTGKS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:58:47 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:59028 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265072AbTGKSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:50:11 -0400
Date: Fri, 11 Jul 2003 21:04:53 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sound updating, security of strlcpy and a question on pci v
 unload
In-Reply-To: <1057943137.20637.27.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm currently updating the prehistoric OSS audio code in 2.5 to include
> all the new 2.4 drivers and 2.4 work. While some of them overlap ALSA
> drivers others are not in ALSA yet either.
>
> Firstly someone turned half the kernel into using strlcpy. Every single
> change I looked at bar two in the sound layer introduced a security
> hole. It looks like whoever did it just fired up a perl macro without
> realising the strncpy properties matter for data copied to user space.
> Looks like the rest wants auditing

What's the difference there? strlcpy always creates null-terminated
string, strncpy doesn't. strncpy in kernel (unlike user strncpy) does not
pad the whole destination buffer with zeros (see comment and
implementation in lib/string.c), so I don't see any point why strncpy
should be more secure.

Mikulas

