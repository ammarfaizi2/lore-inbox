Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288006AbSACARZ>; Wed, 2 Jan 2002 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288057AbSACAQI>; Wed, 2 Jan 2002 19:16:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33552 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288055AbSACAPg>; Wed, 2 Jan 2002 19:15:36 -0500
Subject: Re: [PATCH] C undefined behavior fix
To: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 3 Jan 2002 00:25:18 +0000 (GMT)
Cc: jtv@xs4all.nl (jtv), rth@redhat.com (Richard Henderson),
        velco@fadata.bg (Momchil Velikov), linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz.Sirl-kernel@lauterbach.com (Franz Sirl),
        paulus@samba.org (Paul Mackerras),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        minyard@acm.org (Corey Minyard)
In-Reply-To: <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Jan 02, 2002 05:01:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Lvh8-0006E6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but doesn't -ffreestanding imply that gcc _can't_ assume this is
> the standard library, and that strcpy _might_ not be what it thinks, and
> to just call strpy?

strcpy is part of the C standard. You'd need a -fits-not-c-its-linux

> We aren't saying this is always a bad thing, but what if we want to turn
> off a built-in optimization?  Unless -ffreestanding stops implying
> -fno-builtin (maybe we could just add -fno-builtin for this one file..),
> this line should be fine.

If you want a strcpy that isnt strcpy then change its name or use a
different language 8)
