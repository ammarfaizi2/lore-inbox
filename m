Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312913AbSDJM1t>; Wed, 10 Apr 2002 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312923AbSDJM1s>; Wed, 10 Apr 2002 08:27:48 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:11733 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312913AbSDJM1r>; Wed, 10 Apr 2002 08:27:47 -0400
From: <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Horton <pdh@berserk.demon.co.uk>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
Date: Wed, 10 Apr 2002 14:27:50 +0100
Message-Id: <20020410132751.13616@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.21.0204101403400.9914-100000@vervain.sonytel.be>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Probably not (unless you can quote me on that :-)
>
>The color map is saved/restored in radeonfb_switch().
>
>Gr{oetje,eeting}s,

Yes, the console color map is, but isn't an fbdev app like MOL or
X supposed to restore it's own colormap when switched back in ?
Well, I may be able to quote you on this...

>>  - When using > 8 bit depth, who is supposed to set the linear
>>    gamma ramp ? (My understanding is that a client app is responsible
>>    to set it's own cmap properly, but it also looks like some apps
>>    rely on the default beeing set to a linear gamma ramp). Should
>>    I set it this way in set_par by default and then let the app
>>    eventually change it ?
>
>If your fbdev claims to be in truecolor mode, your fbdev should do it.
>If your fbdev claims to be in directcolor mode, the application should do it
>(if the app wants truecolor mode).

Ok, actually, you weren't talking about console switch. Though I'm pretty
sure MOL at least will properly restore it's colormap, I don't know for
XFree.

So Peter, it seems you have to save/restore it all finally.

Ben.


