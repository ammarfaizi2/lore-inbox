Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135179AbRAVUVY>; Mon, 22 Jan 2001 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135282AbRAVUVP>; Mon, 22 Jan 2001 15:21:15 -0500
Received: from hood.tvd.be ([195.162.196.21]:38559 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S135179AbRAVUVF>;
	Mon, 22 Jan 2001 15:21:05 -0500
Date: Mon, 22 Jan 2001 21:20:07 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Freeze: atyfb & XFree4.0.1
In-Reply-To: <20010122172009.A1437@lug-owl.de>
Message-ID: <Pine.LNX.4.05.10101222118440.13798-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Jan-Benedict Glaw wrote:
> I just discovered a solid freeze:
> jbglaw@jbglaw-sid:~$ uname -r
> 2.4.1-pre8
> jbglaw@jbglaw-sid:~$ grep aty /etc/lilo.conf
>         append="video=atyfb:800x600
> 
> Parts of /etc/X11/XF86Config-4:
> 
> 	Section "Device"
> 		Identifier	"Generic Video Card"
> 		Driver		"ati"
> 	EndSection
>         SubSection "Display"
>                 Depth           24
>                 Modes           "1024x768"
>         EndSubSection
> 
> 
> Now, when I switch from X to a configured virtual console (eg. tty1),
> everything is okay. But if I press <Ctrl><Alt><F12> (for example)
> the system just dies. I've not yet attached a serial console,
> but SysRq keys seem to not be functional, as well as the NumLock
> LED doesn't change when pressing the NumLock key...

The `CONFIG_FB' entry in Documentation/Configure.help says:

|   If you are compiling for the x86 architecture, you can say Y if you
|   want to play with it, but it is not essential. Please note that
|   running graphical applications that directly touch the hardware
|   (e.g. an accelerated X server) and that are not frame buffer
|   device-aware may cause unexpected results. If unsure, say N.

XFree86 4.x is not fbdev-aware (yet), unless you specify some `UseFBDev' option
keyword (exact syntax may differ, I don't run 4.x yet).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
