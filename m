Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSBRV5e>; Mon, 18 Feb 2002 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSBRV5Z>; Mon, 18 Feb 2002 16:57:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64008 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288019AbSBRV5M>; Mon, 18 Feb 2002 16:57:12 -0500
Subject: Re: jiffies rollover, uptime etc.
To: oh@novaville.de (Oliver Hillmann)
Date: Mon, 18 Feb 2002 22:10:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10202182040260.11179-100000@rimini.novaville.de> from "Oliver Hillmann" at Feb 18, 2002 10:42:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cvzs-0006y2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> counter, and I'm currently digging into that area... Stuff like a pc
> speaker driver going wild bothers me a bit more...

Fix the speaker driver I guess is the answer. It shouldnt have done that.

> Could anybody perhaps tell me why he/she doesn't consider this a
> problem? And is there a fundamental problem with solving this in
> general? (I do see a problem with defining jiffies long long on x86,
> because it might break a lot of things and probably wouldnt perform
> as often as jiffies is touched... And you might sense I haven't
> been into kernel hacking much...)

Counting in long long is expensive and the drivers are meant to all use
roll over safe compares
