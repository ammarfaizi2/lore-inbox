Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSHHHsR>; Thu, 8 Aug 2002 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHHHsR>; Thu, 8 Aug 2002 03:48:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14090 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316161AbSHHHsQ>; Thu, 8 Aug 2002 03:48:16 -0400
Message-ID: <3D5221D3.7090807@evision.ag>
Date: Thu, 08 Aug 2002 09:46:27 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <UTC200208071843.g77IhUc20546.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since 2.5.30 many people will have a different geometry, so many
> people will have to find grub or a recent LILO, or add "linear"
> to their old LILO. This is all well understood - I just repeat it
> a few times in the hope that that will reduce the amount of email.

I think you confuse two entierly unrelated issues a bit:

1. Remapping s single sector and thus making the behaviour of dd
if=/dev/hda /of=dev/hdb less then intuitive, namely: severly BROKEN. It 
doesn't matter that this was broken for years. Now I can remember it did 
bite me once I tryed to clone a system precisely in the dd way. (Of
course rerunning lilo on the clone wasn't impossible for me...) The only
thing which makes me worry here are the problems Petr was reporting about...

2. The xlate trick which was only supposed to be used by the MSDOS fs
driver and only on i386 and only if this thing was residuent and 
ide-disk was not compiled as a module and so on. This is actually the
*geometry* issue. If someone needs access to an MS-DOS partition, well
he can always resort to mtools. FAT16, which is likely the affected 
variant of FAT filesystem, was broken before anyway and I have still to
recheck whatever the removal of the geomtry "translation" didn't even 
maybe make my CF PSION system disk readbale.

