Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277303AbRJEERM>; Fri, 5 Oct 2001 00:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277306AbRJEERC>; Fri, 5 Oct 2001 00:17:02 -0400
Received: from jxmls03.se.mediaone.net ([24.129.0.111]:51443 "EHLO
	jxmls03.se.mediaone.net") by vger.kernel.org with ESMTP
	id <S277303AbRJEEQy>; Fri, 5 Oct 2001 00:16:54 -0400
Message-ID: <3BBD3535.272FE822@mediaone.net>
Date: Fri, 05 Oct 2001 00:21:09 -0400
From: walt <wanthony@mediaone.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lamarts@flash.net, linux-kernel@vger.kernel.org
Subject: Re:Failure to get login prompt - after compiled 2.4.10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Lamar Seifuddin" <lamarts@flash.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, October 04, 2001 6:55 PM
Subject: Failure to get login prompt - after compiled 2.4.10


> All,
>
> I compiled the 2.4.10 linux kernel on my Compaq Armada E700 P-III
> where RedHat 7.1 - 2.4.2-2 was located.
>
> I followed the directions using the "newbie" url
>
> http://kernelnewbies.org/faq/index.php3#compile.xml
>
> after several shots at it (more or less refining the type of
configuration),
> I was successful at creating a bzImage file.....loaded it......etc.
>
> After rebooting the pc, I can't seem to get back to the login page.
> It's a black screen.  I'm sure I have to check the graphics
configuration.
>
> Question:   How do I get back to some sort of prompt, so I can
recompile
> the kernel again?
>
> thank you,
>
> Lamar
>


Did you overwrite /boot/vmlinuz-2.4.x or did you copy bzImage to /boot
and add it to lilo as
"another" OS? If so, you should be able to boot off the orgional kernel.

If not, the only thing I know to do is reinstall RH 7.1 and choose the
upgrade option.
Below is a sample of my /etc/lilo.conf which boots the orgional RH 6.2
kernal as default,
boots 2.2.19 as new, boots 2.4.2 as 2.4.2, and boots windows as dos.

boot=/dev/hda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
linear
default=linux

image=/boot/vmlinuz-2.2.14-5.0
        label=linux
        initrd=/boot/initrd-2.2.14-5.0.img
        read-only
        root=/dev/hda2

image=/boot/bzImage
        label=new
        initrd=/boot/initrd-2.2.19.0.img
        read-only
        root=/dev/hda2

image=/boot/bzImage-2.4
        label=2.4
        read-only
        root=/dev/hda2

other=/dev/hda1
        label=dos


walt

