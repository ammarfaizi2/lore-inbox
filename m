Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAXSp5>; Wed, 24 Jan 2001 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAXSpr>; Wed, 24 Jan 2001 13:45:47 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:20750 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129811AbRAXSp1>;
	Wed, 24 Jan 2001 13:45:27 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: f5ibh <f5ibh@db0bm.ampr.org>
Date: Wed, 24 Jan 2001 19:42:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: display problem with matroxfb
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1382C05A16AC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 01 at 10:32, f5ibh wrote:
> > Grr. Did not pass through due to DUL blacklist...
> What is DUL blacklist ?
> If the problem is with my e-mail address (it is an hamradio address), you can
> use <jean-luc.coulon@wanadoo.fr> instead.

No. Problem is with linux-kernel@... It started blacklisting direct
mails from dialups, so I have to implement some workaround on my side
(as I do not want to use provider's SMTP gateway - I do not trust them).

> > Can you try 'video=matrox:init' ? And 'video=matrox:nopan'?
> 
> Bingo ! 'init' does not work but 'nopam' give me a normal display without the
> fbset gimnick.

It looks like that there is some problem with screen offset computation then.
Can you try 'video=matrox:cross4MB' instead of '...:nopan'? I did not
have 8MB Mystique for testing, and it even looks reasonable - Mystique
does not use WRAM memory, so there is no need for WRAM workarounds.
If it will work, I'll cook twoliner for Linus.
 
> Next step will be to test dual head. I've already installed an AGP ATI (S3
> chipset) together with the PCI matrox Mystique and it seems to work. If I
> succeed, I will attach a normal VGA display on the ATI board and a 19" IBM (not
> multisync) on the Matrox. The ATI card is a cheap one with only 4Mb RAM. I've
> upgraded my Matrox Mystique to 8Mb, so I hope it will work.
> Now, I will have a look on how to use XF68_FBDev (if needed).

XF4.0.x should work reasonably well. Or you can run accelerated XF on mga:
matroxfb is compatible with accelerated XF 3.3.x, and with accelerated
XF 4.0.x WITHOUT enabled DRI (as DRI code reprograms hardware even if
X are on background) (and 'Option "UseFBDev"' is required if you are
using both heads of G400/G450 with XF4).
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
