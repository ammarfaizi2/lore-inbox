Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbTDCKuW>; Thu, 3 Apr 2003 05:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbTDCKuW>; Thu, 3 Apr 2003 05:50:22 -0500
Received: from [66.70.28.20] ([66.70.28.20]:62479 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S263347AbTDCKuV>; Thu, 3 Apr 2003 05:50:21 -0500
Date: Thu, 3 Apr 2003 12:10:33 +0200
From: DervishD <raul@pleyades.net>
To: Greg KH <greg@kroah.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Mouse issue
Message-ID: <20030403101033.GC47@DervishD>
References: <20030402193731.GA1273@DervishD> <20030403005344.GA5361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030403005344.GA5361@kroah.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Greg :)

 Greg KH dixit:
> >     But when I do 'gpm -m mouse -p -t imps2' I have a 'ENODEV'. Same
> > if I try to open 'mouse' with cat or the like, always ENODEV:
> >     crw-r--r--  1 root root 180,16 mouse
> No, this interface (Major 180, minor 16) is long out of date.  You have
> to use the input core now.

    And that means activate INPUT_MOUSEDEV and load the module, ok,
but then, usbmouse does anything? Is it necessary for the USB mouse?
Right now I have INPUT activated, but INPUT_MOUSEDEV not. I have
INPUT_EVDEV activated, which is supposed to work for the Wacom
Graphire digitizer (I have one too), but because the Configure.help
file says so, in USB_MOUSE I don't see such advise :?

    If usbmouse depends on INPUT_MOUSEDEV it should say it in the
Configure.help entry...

    Excuse me, none of the above was needed, just created the node
(char 13,64) and run gpm saying that the mouse is of 'evdev' type. No
INPUT_MOUSEDEV needed :) Just one curiosity: the usbmouse module
shows as 'unused', in fact is 'evdev' the one used by 'gpm', but if I
unload the usbmouse module (which I can do even with gpm running)
then gpm stops working! I mean, the usbmouse module can be rmmod'ed
but it is in use! Is this a bug? I'm afraid I must mark this module
as not autocleanable :((( and it will remain loaded even if I stop
using the mouse. Any advice?

    Thanks for the information, Greg, you've saved me a few hours of
testing ;))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
