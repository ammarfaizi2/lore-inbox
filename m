Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSGaMTi>; Wed, 31 Jul 2002 08:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317996AbSGaMTi>; Wed, 31 Jul 2002 08:19:38 -0400
Received: from zion.devzone.ch ([212.254.206.211]:53933 "EHLO zion.devzone.ch")
	by vger.kernel.org with ESMTP id <S317987AbSGaMTh>;
	Wed, 31 Jul 2002 08:19:37 -0400
Message-ID: <32782.80.218.9.146.1028118133.squirrel@www.devzone.ch>
Date: Wed, 31 Jul 2002 14:22:13 +0200 (CEST)
Subject: Re: 2.4.19-rc3 incorrectly detects PDC20276 in ATA mode as raid controller
From: "Daniel Tschan" <tschan+linux-kernel@devzone.ch>
To: <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.44.0207242256450.31740-100000@freak.distro.conectiva>
References: <32816.80.218.9.155.1027506858.squirrel@www.devzone.ch>
        <Pine.LNX.4.44.0207242256450.31740-100000@freak.distro.conectiva>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

> Yes. The behaviour should be as previous kernels (work with the kernel
> driver by default).
>
> The following patch should fix it.
Yes it does. Line 410 of ide-pci.c should be changed too, from:

#else /* !CONFIG_PDC202XX_FORCE */

to

#else /* CONFIG_PDC202XX_FORCE */


Regards
  Daniel



