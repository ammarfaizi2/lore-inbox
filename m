Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSBKCtZ>; Sun, 10 Feb 2002 21:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSBKCtR>; Sun, 10 Feb 2002 21:49:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286411AbSBKCtC>; Sun, 10 Feb 2002 21:49:02 -0500
Subject: Re: [PATCH] 2.5.4-pre6 apm compile fix
To: reality@delusion.de (Udo A. Steinberg)
Date: Mon, 11 Feb 2002 03:02:35 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3C672BE8.EF4C703F@delusion.de> from "Udo A. Steinberg" at Feb 11, 2002 03:26:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a6jj-0005Gu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I believe this had already been applied in earlier 2.5 and then somehow
> vanished, probably due to an update by whoever maintains apm.c

Doubt it - the 2.4.18pre tree uses a much more uptodate APM code set that
removes the rather broken system_idle check for a new algorithm (and
adds 20% to my typical battery lifetime!). Probably its another thing that
really wants porting forward.

I think its from scheduling changes.

> -#define system_idle() (nr_running == 1)
> +#define system_idle() (nr_running() == 1)

