Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVLDSuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVLDSuL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVLDSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 13:50:11 -0500
Received: from mout2.freenet.de ([194.97.50.155]:37328 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932287AbVLDSuJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 13:50:09 -0500
To: linux-kernel@vger.kernel.org
From: mbuesch@freenet.de
Subject: Broadcom 43xx first results
Cc: bcm43xx-dev@lists.berlios.de
X-Priority: 3
X-Abuse: 503164420 / 85.212.39.112
User-Agent: freenetMail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
Date: Sun, 04 Dec 2005 19:50:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a developer of the Broadcom-43xx driver project.
(The 43xx chipset is used in a lot of chipsets, including
the Apple Airport 2 card).

I am writing this mail on my PowerBook and it is sent
wireless to my AP.
That means, we can transmit real data, if you did not get it, yet. :)

That does _not_ mean, that it completely works, yet.
The team is in the progress of writing a SoftwareMAC layer,
which is needed for the bcm device. The SoftMAC is still very
incomplete. So do not expect to do any fancy stuff like WPA
or something line that with it.
Please be patient, thanks. :)

If you want to try the driver, a few steps have to be done manually,
because the SoftMAC doesn't do them automatically, yet:

insmod ieee80211softmac.ko
insmod bcm430x.ko
ifup ethX
iwconfig ethX channel YOUR_AP_CHANNEL
iwconfig ethX essid ESSID_OF_YOUR_AP
In between you should pray from time to time.

If it works without crashes, cool. :)
If it crashes, well, fix it or send us a complete OOPS message
including detailed information about the device. Most information
about the device is printed on insmod. Including this information is
_important_, because there are so many different devices around.

Do _not_ expect to get any 802.11a based device working, yet. Only b/g
devices should "work".

BCM43xx driver:
http://bcm43xx.berlios.de
Required SoftMAC Layer:
http://softmac.sipsolutions.net

Have fun.



"Jetzt Handykosten senken mit klarmobil - 15 Ct./Min.! Hier klicken"
www.klarmobil.de/index.html?pid=73025

