Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265916AbSKBKKK>; Sat, 2 Nov 2002 05:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265918AbSKBKKK>; Sat, 2 Nov 2002 05:10:10 -0500
Received: from ulima.unil.ch ([130.223.144.143]:28550 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265916AbSKBKKJ>;
	Sat, 2 Nov 2002 05:10:09 -0500
Date: Sat, 2 Nov 2002 11:16:39 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech wheel and 2.5? (PS/2)
Message-ID: <20021102101639.GA27372@ulima.unil.ch>
References: <20021102110316.3c60c30d.khaho@koti.soon.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021102110316.3c60c30d.khaho@koti.soon.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:03:16AM +0200, Kari Hameenaho wrote:

> The packet #0 message is not causing any trouble.
> 
> The wheel will work in X with mouse set to imps/2, in XF86Config(-4):
> Section "InputDevice"
> ..
>     Option "Protocol"    "ImPS/2"
>     Option "ZAxisMapping" "4 5"
> ...
> EndSection

I have changed it ;-)

> Button on left may act same as middle button, at least for me it is and
> nicer to use.
> 
> Mouse position loose seems to be caused by strange messages from mouse:
> is your mouse wireless too ?

Yes it is!

> Here is a patch that works for me: note that it is too ugly for real
> inclusion and may cause troubles in other setups. But you can try it if
> you want. I have sent it to maintainer too, maybe a better solution will
> arrive in future kernels.

patched, but I got:

make -f scripts/Makefile.build obj=drivers/input/mouse
  gcc -Wp,-MD,drivers/input/mouse/.psmouse.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=psmouse   -c -o drivers/input/mouse/psmouse.o drivers/input/mouse/psmouse.c
drivers/input/mouse/psmouse.c: In function `psmouse_process_packet':
drivers/input/mouse/psmouse.c:90: label `out' used but not defined
make[3]: *** [drivers/input/mouse/psmouse.o] Error 1
make[2]: *** [drivers/input/mouse] Error 2
make[1]: *** [drivers/input] Error 2
make: *** [drivers] Error 2

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
