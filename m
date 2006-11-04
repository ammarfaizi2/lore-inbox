Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965744AbWKDXiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965744AbWKDXiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965745AbWKDXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 18:38:13 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:15822 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965744AbWKDXiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 18:38:12 -0500
Date: Sun, 5 Nov 2006 00:38:11 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Albert Cahalan <acahalan@gmail.com>
Cc: kangur@polcom.net, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: New filesystem for Linux
>
> kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
> linux-kernel@vger.kernel.org
>
>
> Grzegorz Kulewski writes:
>> On Thu, 2 Nov 2006, Mikulas Patocka wrote:
>>> As my PhD thesis, I am designing and writing a filesystem,
>>> and it's now in a state that it can be released. You can
>>> download it from http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>> 
>> "Disk that can atomically write one sector (512 bytes) so that
>> the sector contains either old or new content in case of crash."
>
> New drives will soon use 4096-byte sectors. This is a better
> match for the normal (non-VAX!) page size and reduces overhead.

The drive (IDE model, SCSI can have larger sector size) will do 
read-modify-write for smaller writes. So there should be no compatibility 
issues. (this possibility is in new ATA standard and there is a way how to 
detect physical sector size)

But how will fdisk deal with it? Fdisk by default aligns partitions on 
63-sector boundary, so it will make all sectors misaligned and seriously 
kill performance even if filesystem uses proper 8-sector aligned accesses.

Mikulas
