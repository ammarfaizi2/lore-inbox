Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315558AbSEVO5A>; Wed, 22 May 2002 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315580AbSEVO46>; Wed, 22 May 2002 10:56:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49168 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315558AbSEVO4w>; Wed, 22 May 2002 10:56:52 -0400
Message-ID: <3CEBA2D4.4080804@evision-ventures.com>
Date: Wed, 22 May 2002 15:53:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>The Xfree86 people are actually sane and hold up the BSD tradition.
>>They don't even use /proc/bus and killed early /proc/agpgart usage!
>>Quite the reverse is true.
> 
> 
> XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
> and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
> 
> Alan

All the cases you encounter above are cases where Linux
leaks a more palatable interface.

/proc/cpuinfo for one could be replaced by dropping syslog
messages at a fixed file in /etc/ during boot - it's static after
all!.

DRI is one of the few XFree86 things which indeed
got born in the linux context. It should in fact run on
top  of either the /dev/agpgard ir /dev/fb device.
/proc/dri is a war... similar to the former /proc agp stuff..

/proc/bus - is not as bad in my opinnion :-).

