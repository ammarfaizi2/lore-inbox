Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136038AbRA2B6j>; Sun, 28 Jan 2001 20:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136765AbRA2B62>; Sun, 28 Jan 2001 20:58:28 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:32234 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S136038AbRA2B6R>; Sun, 28 Jan 2001 20:58:17 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Mon, 29 Jan 2001 00:57:48
Subject: Re: display problem with matroxfb
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010129015821Z136038-460+994@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001 00:30:34, Petr Vandrovec <vandrove@vc.cvut.cz> 
wrote:

> > > you do not have to specify vesa,pixclock,hslen and vslen, as you leave
> > > them on defaults. 
> > 
> > Talking of defaults for matroxfb, would you consider limiting the fv: 
> > value default to something reasonable that'll work on all monitors? It
> > took me several recompiles/reboots to get a setting that would not put
> > my monitor into auto-powerdown. If you defaulted to fv:60 then it 
> > would work on 99.9% of monitors and then people could override that 
> > upwards. I have a Philips 201B 21" monitor and was using 
> > 
> > append="video=matrox:vesa:400"
> > 
> > and this was setting too high a vertical refresh rate for the monitors
> > capabilities. Adding fv:85 lets it work. The card is a Matrox 
> > Millennium G200 8MB SDRAM.
> 
> Are you sure that it did not run out of horizontal sync, or something
> like that? vesa:400 == vesa:0x190 == 1152x864/60Hz... And it powers
> up in 60Hz, at least here ;-)
> 
> See timmings array in drivers/video/matrox/matroxfb_base.c - all videomodes
> except XXXx400 powerups in fv=60Hz unless you specified fh/fv/pixclock.
> XXXx400 powerups with fv=70Hz, like standard VGA does.

Looks like one you've already fixed. I've retested and recreated it 
but it only happens with 2.2.13 not with the other two kernel sources 
I have (2.2.18 and 2.4.0). I also misinformed you about the way to 
recreate it, I had specified only append="matrox" in my lilo.conf. It 
was 2.2.13 that I did my experimentation on to get it to work in the 
first place and never bothered to retest afterwards. Sorry for the 
false alarm...

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
