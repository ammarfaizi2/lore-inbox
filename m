Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135238AbRAJX3b>; Wed, 10 Jan 2001 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135419AbRAJX3V>; Wed, 10 Jan 2001 18:29:21 -0500
Received: from DKBH-T-003-p-249-160.tmns.net.au ([203.54.249.160]:4111 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S135238AbRAJX3E>;
	Wed, 10 Jan 2001 18:29:04 -0500
Message-ID: <3A5CEFB7.18262D97@eyal.emu.id.au>
Date: Thu, 11 Jan 2001 10:26:47 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] linux-kernel v2.0.39
In-Reply-To: <23111.979089494@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Wed, 10 Jan 2001 10:27:44 +1100,
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> >My 'make dep' fails in the following way. This is on Debian 2.2, I
> >commented
> >if [ -n "amigamouse.c atarimouse.c atixlmouse.c baycom.c busmouse.c
> >cd1865.h conmakehash.c console.c console_struct.h consolemap.c
> >consolemap.h cyclades.c defkeymap.c diacr.h digi.h digi_bios.h
> >digi_fep.h fbmem.c fep.h h8.c h8.h isicom.c istallion.c kbd_kern.h
> >keyb_m68k.c keyboard.c lp.c lp_intern.c lp_m68k.c mem.c misc.c
> >msbusmouse.c n_tty.c pcwd.c pcxx.c pcxx.h psaux.c pty.c random.c
> >riscom8.c riscom8.h riscom8_reg.h rtc.c scc.c selection.c selection.h
> >serial.c softdog.c specialix.c specialix_io8.h stallion.c tga.c
> >tpqic02.c tty_io.c tty_ioctl.c vc_screen.c vesa_blank.c vga.c vt.c
> >vt_kern.h wd501p.h wdt.c" ]; then \
> >/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
> >make[2]: *** [fastdep] Error 135
> 
> 135 == 128+7 => E2BIG (Arg list too long).  What does
>   ls -l /usr/local/src/linux/drivers/char/*.[chS] | wc
> report?  And which kernel/libc are you compiling on?


This is a current Debian 2.2 (potato, I think it is now at r3)


# ls -l /usr/local/src/linux-2.0/drivers/char/*.[chS] | wc
     62     558    6434

# gcc --version
2.95.2

# uname -a
Linux eyal 2.4.0-ac3 #1 Sun Jan 7 12:15:50 EST 2001 i686 unknown

# ls -l /lib/libc-*.so
-rwxr-xr-x    1 root     root      1057576 Oct 14 05:45
/lib/libc-2.1.95.so

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
