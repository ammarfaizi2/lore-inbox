Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSBCVKI>; Sun, 3 Feb 2002 16:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSBCVJ5>; Sun, 3 Feb 2002 16:09:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287764AbSBCVJl>; Sun, 3 Feb 2002 16:09:41 -0500
Subject: Re: modular floppy broken in 2.5.3
To: alessandro.suardi@oracle.com (Alessandro Suardi)
Date: Sun, 3 Feb 2002 21:22:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C5DA20E.6D503E66@oracle.com> from "Alessandro Suardi" at Feb 03, 2002 09:48:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XU69-0005MJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It turns out this is due to the new PnPBIOS kernel config option:
> 
> [asuardi@dolphin asuardi]$ grep PnPBIOS /proc/ioports 
> 03f0-03f1 : PnPBIOS PNP0c01
> 0600-067f : PnPBIOS PNP0c01
> 0680-06ff : PnPBIOS PNP0c01
>   0800-083f : PnPBIOS PNP0c01
>   0840-084f : PnPBIOS PNP0c01
> 0880-088f : PnPBIOS PNP0c01
> f400-f4fe : PnPBIOS PNP0c01
> 
> But since modular floppy was working before without setting any
>  ioport parameter I'm not entirely sure this is a "feature".

Its a mix of fp and pnpbios things that need untangling. PnPBIOS should
register the resource as not in use, floppy should allocate the right
things not blindly reserve the wrong sized chunks
