Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129959AbQLLQAg>; Tue, 12 Dec 2000 11:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQLLQA0>; Tue, 12 Dec 2000 11:00:26 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:57614 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129959AbQLLQAV>;
	Tue, 12 Dec 2000 11:00:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tigran Aivazian <tigran@veritas.com>
Date: Tue, 12 Dec 2000 16:28:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: how to capture long oops w/o having second machine
CC: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <F7716111F69@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 00 at 13:31, Tigran Aivazian wrote:
> > > I'm gonna try to compile in a framebuffer and use a high resolution and
> > > see if that'll hold it all when I get back later today.
> > 
> > shift+pageup ?
> 
> the problem with Shift-PgUP is that all the framebuffer drivers I tried
> (matrox, ati, vesa) corrupt the screen when it is used. The only way to
> use Shift-PgUp reliably I have ever seen was on vgacon. These bugs seemed
> to be there for years so I didn't even bother reporting them - I just got
> used to the idea "using fb? forget the Shift-PgUP then".

Do not hit 'shift-pgup' while penguin logo is on the screen. Something
somewhere is wrong... (and never hit shift-pgdn; shift-pgup corrupts
screen while shift-pgdn corrupts kernel memory)

Or better, boot with 'video=scrollback:0' (*). I think that we should 
make this default for 2.4, as (except this problem) scrollback code is 
broken for multihead and fix is not trivial.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

(*) With matrox in 8bpp you'll get almost always bigger and faster scrollback
with 'video=scrollback:0' than with default 'scrollback:32768' ...
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
