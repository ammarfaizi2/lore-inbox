Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRFGLGQ>; Thu, 7 Jun 2001 07:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbRFGLGG>; Thu, 7 Jun 2001 07:06:06 -0400
Received: from deckard.concept-micro.com ([62.161.229.193]:58213 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S262432AbRFGLFz>; Thu, 7 Jun 2001 07:05:55 -0400
Message-ID: <XFMail.20010607130535.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B1C33C5.AB6C8CD0@uow.edu.au>
Date: Thu, 07 Jun 2001 13:05:35 +0200 (CEST)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: lowlatency 2.2.19
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        William Montgomery <william@opinicus.com>,
        safemode <safemode@voicenet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 05-Jun-2001, Andrew Morton écrivait :
> Some video cards have a PCI cheat-mode in which they keep
> the PCI bus busy until they are ready to accept new
> commands, rather forcing a retry.  Figures of up to
> twenty milliseconds have been mentioned.  Your X server
> *may* support the `PCIRetry' config option which will
> defeat this.

Just FYI (I think it's S3 Virge specific, but maybe not), I solved my RX
packets loss on my ADSL interface after I read the message

        http://www.xfree86.org/pipermail/xpert/2000-November/003402.html

and used

Section "Device"
        Identifier      "Generic Video Card"
        Driver          "s3virge"
        Option "fpm_vram"
        Option "fifo_aggressive"
        Option "pci_burst" "on"
        Option "pci_retry" "on"
        Option "XaaNoCPUToScreenColorExpandFill"
EndSection

in my XFConfig-4.

(The whole thread seems to be worth a read.)

Best regards,
Pierre.


-- 
We are the dot in 0.2 Kb/s
