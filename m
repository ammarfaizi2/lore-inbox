Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSF3NJH>; Sun, 30 Jun 2002 09:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSF3NJG>; Sun, 30 Jun 2002 09:09:06 -0400
Received: from sto-vo-kor.koschikode.com ([213.61.61.142]:14355 "EHLO
	sto-vo-kor.koschikode.com") by vger.kernel.org with ESMTP
	id <S315207AbSF3NJG>; Sun, 30 Jun 2002 09:09:06 -0400
Message-ID: <3D1F0373.9070104@koschikode.com>
Date: Sun, 30 Jun 2002 15:11:15 +0200
From: Juri Haberland <juri@koschikode.com>
Organization: totally unorganized
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301449.51190.roy@karlsbakk.net> <3D1EFF5C.6010405@koschikode.com> <200206301504.35221.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
>> Hm, I'm no lilo nor raid expert, but I'd suggest to strip down the
>> lilo.conf to the defaults. E.g. I have:
>> prompt
>> timeout=50
>> default=linux
>> boot=/dev/md2
>> map=/boot/map
>> install=/boot/boot.b
>> message=/boot/message
>>
>> image=/boot/vmlinuz
>>         label=linux
>>         read-only
>>         root=/dev/md0
> 
> hm...
> still gave me 'LI'
> I beleive it might be because LILO need to be installed on the first drive 
> BIOS finds (/dev/hdm). I might try to address it as 0x80? Do you think 
> that'll help?

I assume the onboard IDE stuff (hdm) is something like a Promise
controller. If so you should be able set the boot order to boot from the
normal IDE chipset (hda/hdb). If doesn't help I'd suggest that you ask
on the linux-raid mailing list.

Cheers,
Juri

