Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRACS23>; Wed, 3 Jan 2001 13:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRACS2T>; Wed, 3 Jan 2001 13:28:19 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:5371
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129692AbRACS2M>; Wed, 3 Jan 2001 13:28:12 -0500
Date: Wed, 3 Jan 2001 10:54:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] matroxfb as a module (PPC)
Message-ID: <20010103105452.X26653@opus.bloom.county>
In-Reply-To: <20010103091613.Q26653@opus.bloom.county> <Pine.LNX.4.05.10101031840410.611-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.05.10101031840410.611-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, Jan 03, 2001 at 06:44:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 06:44:59PM +0100, Geert Uytterhoeven wrote:
> On Wed, 3 Jan 2001, Tom Rini wrote:
> > Third, the nvram_read_byte needs to be protected by CONFIG_NVRAM.
> 
> I'd really like to move the nvram part to mac_fb_find_mode() in macmodes.c, so
> it will work automagically for all drivers on PowerMac.
> 
> I'd also like to remove the `vmode' and `cmode' `video=' arguments, in favor of
> the archictecture-neutral `<xres>x<yres>[-<bpp>][@<refresh>]' and
> `<name>[-<bpp>][@<refresh>]' arguments (which already work on mac, BTW).

Quite wonderfully, almost.  My monitor (ViewSonic G810) claims it can do
1280x1024@90, but when i boot with that on my x86 box, it comes up at 87.5
or so (and shifted to the left ~1 penguin).  But anyways..

> You can already use `mac<vmode>' instead of `vmode:<vmode>'.

Ah, is this documented anywhere?  I'm sure it'd make some peoples life
easier.

> IMHO, the less PowerMac-specific code in _each_ driver, the better.

I agree this sounds good.  I just think it's too late to do it now. :)

The vmode/cmode/vesa number stuff should stick around in 2.4 (it's too late
now to remove it) but documented as obsolete, and removed in 2.5.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
