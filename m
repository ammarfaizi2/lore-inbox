Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278597AbRJaAzu>; Tue, 30 Oct 2001 19:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278653AbRJaAzk>; Tue, 30 Oct 2001 19:55:40 -0500
Received: from modem-4092.leopard.dialup.pol.co.uk ([217.135.159.252]:28682
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S278597AbRJaAzW>; Tue, 30 Oct 2001 19:55:22 -0500
Posted-Date: Wed, 31 Oct 2001 00:51:29 GMT
Date: Wed, 31 Oct 2001 00:51:29 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Marko Rauhamaa <marko@pacujo.nu>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
In-Reply-To: <20011030035221.6E5611FE7D@varmo.pacujo.nu>
Message-ID: <Pine.LNX.4.21.0110310046000.19579-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marko.

> PS Are /dev/null and /dev/zero also redundant?

I regularly use both...

 1. Find a download that doesn't appear where one expected it...

	find / -name "wanted-but-lost-download" 2> /dev/null

 2. Create a loop-mounted partition to populate as a CD image before
    burning the CD in question.

	dd if=/dev/zero bs=1048576 count=750 of=/tmp/cd.img
	mke2fs /tmp/cd.img
	mount -o loop /tmp/cd.img /img/cd

 3. Create a loop-mounted partition to populate as a floppy image.

	dd if=/dev/zero bs=1024 count=1440 of=/tmp/floppy.img
	mke2fs /tmp/floppy.img
	mount -o loop /tmp/floppy.img /img/floppy

Neither has alternatives that make sense as far as I can see.

Best wishes from Riley.

