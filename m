Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbSKDOKy>; Mon, 4 Nov 2002 09:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSKDOKy>; Mon, 4 Nov 2002 09:10:54 -0500
Received: from hermes.domdv.de ([193.102.202.1]:50443 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S263330AbSKDOKx>;
	Mon, 4 Nov 2002 09:10:53 -0500
Message-ID: <3DC68148.3070307@domdv.de>
Date: Mon, 04 Nov 2002 15:16:40 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20rc1 compile fix for t128.c
References: <3DC67810.9010704@domdv.de> <1036419832.1106.50.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[forgot to cc lkml]

Alan Cox wrote:
> On Mon, 2002-11-04 at 13:37, Andreas Steinmetz wrote:
> 
>>The attached patch fixes a section type conflict error.
> 
> 
> Which compiler is showing this problem ?
> 

gcc 3.2

> 
>>--- ./drivers/scsi/t128.c.orig	2002-11-04 14:21:30.000000000 +0100
>>+++ ./drivers/scsi/t128.c	2002-11-04 14:21:47.000000000 +0100
>>@@ -145,7 +145,7 @@
>> static const struct signature {
>> 	const char *string;
>> 	int offset;
>>-} signatures[] __initdata = {
>>+} signatures[] = {
>> 	{"TSROM: SCSI BIOS, Version 1.12", 0x36},
> 
> 
> Far better to lose the const
> 

any way you please.

> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

