Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSHDPmW>; Sun, 4 Aug 2002 11:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSHDPmW>; Sun, 4 Aug 2002 11:42:22 -0400
Received: from dsl-213-023-061-042.arcor-ip.net ([213.23.61.42]:272 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S318123AbSHDPmT>;
	Sun, 4 Aug 2002 11:42:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmxpro.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Sun, 4 Aug 2002 17:46:56 +0200
User-Agent: KMail/1.4.1
References: <fa.egf7e0v.kk5a2@ifi.uio.no> <60bc.3d4d4347.5dd06@trespassersw.daria.co.uk>
In-Reply-To: <60bc.3d4d4347.5dd06@trespassersw.daria.co.uk>
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041746.56274.kiza@gmxpro.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 17:07, Jonathan Hudson wrote:
>
> Not so. USB Mouse works just fine here on 2.4.19.
>
> $ lsmod
> ....
> mousedev                4352   1
> hid                    14112   0 (unused)
> input                   3328   0 [mousedev hid]
> ....
>
> CONFIG_INPUT=m
> # CONFIG_INPUT_KEYBDEV is not set
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
>
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDDEV is not set
>
> 'cat /dev/input/mice' (a cat and mouse game?) gives output as well.
>
> So there appears to be no generic 2.4.19 problem.

Hm, seems so. The relevant options I used are:

CONFIG_INPUT=y
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m

CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y

I don't know if it's a config problem. First I suspected CONFIG_USB_HIDINPUT 
could be the problem because it's new in 2.4.19. But as I see it works for 
you, so there shouldn't be a problem.

-- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/

