Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314274AbSD2J2i>; Mon, 29 Apr 2002 05:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314624AbSD2J2i>; Mon, 29 Apr 2002 05:28:38 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:33804 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S314274AbSD2J2h>; Mon, 29 Apr 2002 05:28:37 -0400
Subject: Re: 2.5.11 framebuffer compilation error
From: Miles Lane <miles@megapathdsl.net>
To: ivangurdiev@linuxfreemail.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <02042823533500.06684@cobra.linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 29 Apr 2002 02:26:34 -0700
Message-Id: <1020072394.7662.2.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit this error as well.  Here is the pertinent .config snippet.

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y


On Sun, 2002-04-28 at 22:53, Ivan G. wrote:
> I'll know this kernel is ready for merger with the 2.4 when I can finally 
> compile it :) ... must have tried 6-7 versions by now ...
> 
> Error:
> Note...this is something new that I haven't tried to compile before.
> Error might be caused by an earlier kernel.
> However, 2.5.11 does contain a lot of screen_base changes. 
> ________________________________________________
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.11/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -DKBUILD_BASENAME=fbcon_cfb8  -DEXPORT_SYMTAB -c fbcon-cfb8.c
> fbcon-cfb8.c: In function `fbcon_cfb8_bmove':
> fbcon-cfb8.c:55: structure has no member named `screen_base'
> fbcon-cfb8.c:56: structure has no member named `screen_base'
> fbcon-cfb8.c:66: structure has no member named `screen_base'
> fbcon-cfb8.c:67: structure has no member named `screen_base'
> fbcon-cfb8.c:74: structure has no member named `screen_base'
> fbcon-cfb8.c:75: structure has no member named `screen_base'
> fbcon-cfb8.c:52: warning: `src' might be used uninitialized in this function
> fbcon-cfb8.c:52: warning: `dst' might be used uninitialized in this function
> fbcon-cfb8.c: In function `fbcon_cfb8_clear':
> fbcon-cfb8.c:100: structure has no member named `screen_base'
> fbcon-cfb8.c:96: warning: `dest' might be used uninitialized in this function
> fbcon-cfb8.c: In function `fbcon_cfb8_putc':
> fbcon-cfb8.c:118: structure has no member named `screen_base'
> fbcon-cfb8.c:114: warning: `dest' might be used uninitialized in this function
> fbcon-cfb8.c: In function `fbcon_cfb8_putcs':
> fbcon-cfb8.c:165: structure has no member named `screen_base'
> fbcon-cfb8.c:160: warning: `dest0' might be used uninitialized in this 
> function
> fbcon-cfb8.c: In function `fbcon_cfb8_revc':
> fbcon-cfb8.c:222: structure has no member named `screen_base'
> fbcon-cfb8.c:219: warning: `dest' might be used uninitialized in this function
> fbcon-cfb8.c: In function `fbcon_cfb8_clear_margins':
> fbcon-cfb8.c:247: structure has no member named `screen_base'
> fbcon-cfb8.c:250: structure has no member named `screen_base'
> make[3]: *** [fbcon-cfb8.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.11/drivers/video'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.11/drivers/video'
> make[1]: *** [_subdir_video] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.11/drivers'
> make: *** [_dir_drivers] Error 2
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

