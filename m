Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSK3Uyd>; Sat, 30 Nov 2002 15:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSK3Uyd>; Sat, 30 Nov 2002 15:54:33 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:38091 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261529AbSK3Uyd>; Sat, 30 Nov 2002 15:54:33 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C99 initializers for drivers/media/radio
In-Reply-To: <20021130174509.GD10613@debian>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18IEk7-0003yA-00@calista.inka.de>
Date: Sat, 30 Nov 2002 22:01:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021130174509.GD10613@debian> you wrote:
> Here's a patch set for switching drivers/media/radio to use C99
> initializers. The patches are against 2.5.50.
...
> static struct pcm20_device pcm20_unit = {
> -       freq:   87*16000,
> -       muted:  1,
> -       stereo: 0
> +       .freq   = 87*16000,
> +       .muted  = 1,
> };
...

IMHO it is not a good idea to skip default initilised members. IT is self
documenting to see all members, and it is easier to change them, if
required. Especially if the old code had it.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
