Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUBNOLi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 09:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBNOLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 09:11:38 -0500
Received: from papadoc.bayour.com ([212.214.70.53]:63630 "EHLO
	papadoc.bayour.com") by vger.kernel.org with ESMTP id S261950AbUBNOLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 09:11:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Adaptec ARO-1130CA-C
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
Date: 14 Feb 2004 15:11:33 +0100
Message-ID: <87ptchzr6y.fsf@papadoc.bayour.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a motherboard (Intel DK440LX) with a built in SCSI controller
(AIC-7895). To this MB there's the possibility to have a RAIDport II
controller. I managed to get me a 'Adaptec ARO-1130CA-C' from eBay
because I couldn't in my wildest dreams believe that Linux didn't
support it - it's ancient!.

Woe my surprise when I discovered that it isn't! The latest information
I have about this - which is "no, it isn't supported" - come from 2002
or thereabouts. I have not been able to find ANYTHING later than 2002,
other than a note from Alan Cox (http://marc.theaimsgroup.com/?l=linux-kernel&m=92185700225899&w=2)
stating that _maybe_ the new AACRAID _might_ support this. Looking at
the AIC7xxx documentation (in 2.4.24), I see the following, so clearly
it isn't supported by the aic7xxx driver, but my hopes are that AACRAID
DOES support it.


drivers/scsi/README.aic7xxx:
----- s n i p -----
  Not Supported Devices
  ------------------------------
    Adaptec Cards
    ----------------------------
    AHA-2920 (Only the cards that use the Future Domain chip-set are not
              supported, any 2920 cards based on Adaptec AIC chip-sets,
              such as the 2920C, are supported)
    AAA-13x Raid Adapters
    AAA-113x Raid Port Card

    Motherboard Chipsets
    ----------------------------
    AIC-781x

    Bus Types
    ----------------------------
    R - Raid Port busses are not supported.

    The hardware RAID devices sold by Adaptec are *NOT* supported by this
    driver (and will people please stop emailing me about them, they are
    a totally separate beast from the bare SCSI controllers and this driver
    can not be retrofitted in any sane manner to support the hardware RAID
    features on those cards - Doug Ledford).
----- s n i p -----

It is NOT a 'AAA-113x', but I guess it's the same card with a different vendor.
So the question is: IS it (my RAIDport II card) supported by the aacraid driver,
in either 2.4 _or_ (if need be) the 2.6 kernels?
