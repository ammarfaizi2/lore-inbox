Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317310AbSFCI1d>; Mon, 3 Jun 2002 04:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317311AbSFCI1c>; Mon, 3 Jun 2002 04:27:32 -0400
Received: from [212.234.221.113] ([212.234.221.113]:8513 "EHLO mail.cev-sa.com")
	by vger.kernel.org with ESMTP id <S317310AbSFCI1c>;
	Mon, 3 Jun 2002 04:27:32 -0400
Message-ID: <035001c20ad8$5d897b60$6601a8c0@stlo.cevsa.com>
From: =?ISO-8859-1?Q? "Fran=E7ois?= Leblanc" 
	<francois.leblanc@cev-sa.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0205251543260.15278-100000@vervain.sonytel.be>
Subject: Re: [PATCH] kernel 2.4.18 endianness logical mistakes correction onfbcon-cfb2.c and fbcon-cfb4.c
Date: Mon, 3 Jun 2002 10:26:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patchs correct the endianness logical of nibbletab, the first table
is
> > u_char mades so no endian needed and the second swap correctly bytes in
> > LITTLE_ENDIAN. (old version swap half bytes instead of bytes).
>
> For pixels smaller than a byte, it also depends on what's the order of the
> pixels in a byte. So all possibilities are actually possible.

All is possible but for LITTLE ENDIAN and BIG ENDIAN are clearly defined by
the swap of bytes only and not the order of bytes, you can't use the same
definition LITTLE_ENDIAN for swapping bytes in part of hardware (0xABCD ->
0xCDAB) and swapping bytes orders in overs hardwares parts (0xABCD ->
0xDCBA). I suppose this swap order has been introduced for specifics
hardwares requirements, it's ok but only with another option than LITTLE
ENDIAN, since it's incoherent.

François.


