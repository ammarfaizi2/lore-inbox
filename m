Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbTIJTB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTIJS7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:59:54 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:34971 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S265525AbTIJS7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:59:40 -0400
Message-ID: <39807.192.168.9.10.1063220375.squirrel@ncircle.nullnet.fi>
In-Reply-To: <1063140808.30962.0.camel@dhcp23.swansea.linux.org.uk>
References: <3F5E14FC.5090001@yingternet.com>
    <1063140808.30962.0.camel@dhcp23.swansea.linux.org.uk>
Date: Wed, 10 Sep 2003 21:59:35 +0300 (EEST)
Subject: Re: wierd raid 1 problem
From: "Tomi Orava" <tomimo+linux-kernel@ncircle.nullnet.fi>
To: linux-kernel@vger.kernel.org
Cc: "Ying-Hung Chen" <ying@yingternet.com>
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Maw, 2003-09-09 at 18:59, Ying-Hung Chen wrote:
>> the corrupted files seem to 'recover' itself if i leave the machine
>> alone for a while or umount and mount back the filesystem.
>>
>> does anyone have this type of temperory file corruption problem? I
>> tested it against 2.4.2x kernel including the last vanilla 2.4.22 + xfs
>> patches, they all seem to have the same problem
>
> Classic symptoms of bad memory or a kernel bug corrupting data. See if
> the box passes memtest86 as a starter

I actually saw the same thing happen to me a week ago with
linux-2.4.23-pre1+xfs (xfs bk).

The really wierd thing was that I copied several big files from one
disk-array to another and ran md5sum before & after the copy. The files
were instact before copying, but failed right after the copy. When I
started investigating what the hell is wrong, the next md5sum on the
destination filesystem was succesfull ... and that was it (no more errors).

The source filesystem was two disk RAID1 array with XFS (Sil680).
The destination filesystem was RAID1+0 four disk array with XFS as well
(HPT374 with hightech binary driver 1.10, as 2.4.22 still doesn't work at
all with Epox 8K9A3+ motherboard's integrated HPT374 with dma).

I ran the latest memtest86 for 24h (29 passes) without any errors.

Regards,
Tomi Orava


