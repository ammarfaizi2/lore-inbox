Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSLVMKy>; Sun, 22 Dec 2002 07:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSLVMKy>; Sun, 22 Dec 2002 07:10:54 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:42446 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266379AbSLVMKw>;
	Sun, 22 Dec 2002 07:10:52 -0500
Date: Sun, 22 Dec 2002 13:17:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: xxx_check_var
In-Reply-To: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
Message-ID: <Pine.GSO.4.21.0212221315451.11715-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, James Simmons wrote:
> > > When I look at atyfb_check_var or aty128fb_check_var, I see that they
> > > will alter the contents of *info->par.  Isn't this a bad thing?  My
> >
> > Yes, this wrong, and afaik, it's your original port to 2.5 that did that
> > ;)
> 
> Yeap. The idea of check_var is to validate a mode. Note modedb uses just
> check_var. It is okay to READ the values in your par. You shouldn't alter
> the values in par.

Perhaps it makes sense to make the info parameter of fb_check_var() const to
prevent this from happening?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

