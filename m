Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbSKDNzl>; Mon, 4 Nov 2002 08:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSKDNzl>; Mon, 4 Nov 2002 08:55:41 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20624 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264675AbSKDNzl>; Mon, 4 Nov 2002 08:55:41 -0500
Subject: Re: [PATCH] 2.4.20rc1 compile fix for t128.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC67810.9010704@domdv.de>
References: <3DC67810.9010704@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 14:23:52 +0000
Message-Id: <1036419832.1106.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 13:37, Andreas Steinmetz wrote:
> The attached patch fixes a section type conflict error.

Which compiler is showing this problem ?

> --- ./drivers/scsi/t128.c.orig	2002-11-04 14:21:30.000000000 +0100
> +++ ./drivers/scsi/t128.c	2002-11-04 14:21:47.000000000 +0100
> @@ -145,7 +145,7 @@
>  static const struct signature {
>  	const char *string;
>  	int offset;
> -} signatures[] __initdata = {
> +} signatures[] = {
>  	{"TSROM: SCSI BIOS, Version 1.12", 0x36},

Far better to lose the const

