Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144567AbRA2AaC>; Sun, 28 Jan 2001 19:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144583AbRA2A3w>; Sun, 28 Jan 2001 19:29:52 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:10758 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S144567AbRA2A3p>; Sun, 28 Jan 2001 19:29:45 -0500
Date: Mon, 29 Jan 2001 01:28:48 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: trevor-hemsley@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: display problem with matroxfb
Message-ID: <20010129012848.A16593@platan.vc.cvut.cz>
In-Reply-To: <20010129011553.A1085@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129011553.A1085@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Jan 29, 2001 at 01:15:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > you do not have to specify vesa,pixclock,hslen and vslen, as you leave
> > them on defaults. 
> 
> Talking of defaults for matroxfb, would you consider limiting the fv: 
> value default to something reasonable that'll work on all monitors? It
> took me several recompiles/reboots to get a setting that would not put
> my monitor into auto-powerdown. If you defaulted to fv:60 then it 
> would work on 99.9% of monitors and then people could override that 
> upwards. I have a Philips 201B 21" monitor and was using 
> 
> append="video=matrox:vesa:400"
> 
> and this was setting too high a vertical refresh rate for the monitors
> capabilities. Adding fv:85 lets it work. The card is a Matrox 
> Millennium G200 8MB SDRAM.

Are you sure that it did not run out of horizontal sync, or something
like that? vesa:400 == vesa:0x190 == 1152x864/60Hz... And it powers
up in 60Hz, at least here ;-)

See timmings array in drivers/video/matrox/matroxfb_base.c - all videomodes
except XXXx400 powerups in fv=60Hz unless you specified fh/fv/pixclock.
XXXx400 powerups with fv=70Hz, like standard VGA does.
						Petr Vandrovec
						vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
