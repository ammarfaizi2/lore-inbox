Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSEEP75>; Sun, 5 May 2002 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSEEP74>; Sun, 5 May 2002 11:59:56 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:47865 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313137AbSEEP7z>; Sun, 5 May 2002 11:59:55 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: powerbook G4?
Date: Sun, 5 May 2002 16:59:32 +0100
Message-Id: <20020505155932.25492@smtp.wanadoo.fr>
In-Reply-To: <Pine.GSO.4.30.0205042238160.14678-100000@balu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi folks.
>
>[Sorry if this is considered noise here.]
>
>I would like to know if current 2.4 kernels support the goodies in the new
>powerbook G4 (the gigabit ethernet card, the firewire and usb ports, the
>airport card etc).
>
>I would like to buy one, but first make sure I can happily use linux on
>it. Does anyone have closer experience?

I haven't yet had a chance to play with the latest revision of the machine
(the one with L3 cache), but according to some users, there are a few issues
with it that remain to be fixed (some video problems recognizing the new
larger LCD or the Radeon Mobility 7500 and yet a new model of sound chip to
add to dmasound). Hopefully the video issues will be fixed soon, I don't
know for the sound stuff, that depends how long before we identify the exact
chipset Apple used this time and wether specs are available for it or not.

Ethernet should work (the chip is the same sungem cell inside Apple's
ASIC) though they may have changed the PHY model again, requiring a few
tweaks to the sungem driver to get gigabit working. Firewire should work,
USB certainly does, airport as well, the internal modem is a softmodem
from conexant, a driver isn't yet available for it, but that may happen
once Marc Boucher release drivers for USB modems.

Ben.


