Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRKHABN>; Wed, 7 Nov 2001 19:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKHABE>; Wed, 7 Nov 2001 19:01:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281165AbRKHAAy>; Wed, 7 Nov 2001 19:00:54 -0500
Message-ID: <3BE9CB24.1010208@zytor.com>
Date: Wed, 07 Nov 2001 16:00:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brenneke, Matthew Jeffrey (UMR-Student) wrote:

> 
>>Actually, /proc/mounts is currently broken, and is an excellent
>>example of why the above statement simply isn't true unless you apply
>>another level of indirection: try mounting something on a directory
>>the name of which contains whitespace in any form (remember, depending
>>on your setup this may be doable by an unprivileged user...)
>>
> 
>>	-hpa
>>
> 
> 
> mbrennek@spaceheater:/home/mbrennek# mkdir stuff\ and
> mbrennek@spaceheater:/home/mbrennek# mount -t vfat /dev/hda1
> /home/mbrennek/stuff\ and/
> mbrennek@spaceheater:/home/mbrennek# cat /proc/mounts
> /dev/ide/host0/bus0/target1/lun0/part1 / reiserfs rw 0 0
> /dev/hdb2 /home reisferfs rw 0 0
> none /dev/pts devpts rw 0 0
> non /proc proc rw 0 0
> /dev/hda5 /mnt/stuff vfat rw,nosuid,nodev,noexec 0 0
> /dev/hda1 /home/mbrennek/stuff\040and vfat rw 0 0
> mbrennek@spaceheater:/home/mbrennek#
> 
> Are you refering to the 040?
> 


Right, a good example of "additional encapsulation".

	-hpa


