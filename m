Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJTIDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJTIDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:03:49 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:25732 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261882AbTJTIDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:03:45 -0400
Message-ID: <45855.194.237.142.24.1066637022.squirrel@ncircle.nullnet.fi>
In-Reply-To: <975.1066636403@www51.gmx.net>
References: <37972.192.168.9.10.1066602246.squirrel@ncircle.nullnet.fi>
    <975.1066636403@www51.gmx.net>
Date: Mon, 20 Oct 2003 11:03:42 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Svetoslav Slavtchev" <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Are you capable of trying if the hdparm -m0 trick
>> works for you ?
>
> you mean the fs corruption on soft raid or the interupts problem ?
> i dumped the raid setup as i couldn't find a way to debug it
> and my drives are pretty full again, but i'll try to free some space

I meant the interrupt problem, because if that problem exists
there doesn't seem to be a reasonable way to figure out what
is the reason for the filesystem corruption.

> for the interupts
> with test7-bk8  , acpi=off pci=noacpi &
> hdparm  -m0 -d1 -X69  /dev/hd[a,e,g]
> hdparm  -m16 -d1 -X69  /dev/hd[a,e,g]
> i don't see timeouts
> if i omit -m i do see them sometimes

Ok, so if I understood you correctly, the interrupt problem
persists _only_ if you leave the multiple sector setting on
its default setting ? If you explicitly disable it, or set
it to maximum it works fine ? Does it work with any value ?

> (i see them both with -m and without -m if i try to use TCQ )

I'd really like to see the stable series working properly
before jumping into the 2.6-series test kernels ... Although,
I'm still wondering how come TCQ is known to work with 370-chip
as Jens said, but not with 374-chip ...

Regards,
Tomi Orava

-- 
Tomi.Orava@ncircle.nullnet.fi
