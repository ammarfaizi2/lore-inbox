Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSGXKbm>; Wed, 24 Jul 2002 06:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSGXKbm>; Wed, 24 Jul 2002 06:31:42 -0400
Received: from zion.devzone.ch ([212.254.206.211]:42418 "EHLO zion.devzone.ch")
	by vger.kernel.org with ESMTP id <S316960AbSGXKbl>;
	Wed, 24 Jul 2002 06:31:41 -0400
Message-ID: <32816.80.218.9.155.1027506858.squirrel@www.devzone.ch>
Date: Wed, 24 Jul 2002 12:34:18 +0200 (CEST)
Subject: Re: 2.4.19-rc3 incorrectly detects PDC20276 in ATA mode as raid controller
From: "Daniel Tschan" <tschan+linux-kernel@devzone.ch>
To: <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.44.0207231928180.30493-100000@freak.distro.conectiva>
References: <32868.80.218.9.155.1027457806.squirrel@www.devzone.ch>
        <Pine.LNX.4.44.0207231928180.30493-100000@freak.distro.conectiva>
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

This works, thank you. This option didn't get my attention at first
because its named Special FastTrak Feature in xconfig. Perhaps this should
be changed.

> Set CONFIG_PDC202XX_FORCE on.
>
> On Tue, 23 Jul 2002, Daniel Tschan wrote:
>
>> Hi
>>
>> Kernel 2.4.19-rc3 introduces a new bug regarding the Promise PDC20276
>> controller. One of my machines has a Gigabyte GA-8IRXP Motherboard
>> with an onboard Promise PDC20276. The controller can either be run in
>> RAID or in ATA mode. I operate it in ATA mode. Kernel 2.4.19-rc3 now
>> incorrectly skips IDE initialization of the PDC20276 because it thinks
>> it's a RAID controller which results in a kernel panic (the root
>> filesystem is on a harddisk connected to the Promise controller). It
>> outputs a message like this before it panics: PDC20276: Skipping RAID
>> controller. This worked correctly in 2.4.19-rc2.
>>
>> Regards
>> Daniel



