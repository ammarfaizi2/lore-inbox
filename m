Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUAMSUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUAMSUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:20:24 -0500
Received: from host81-130-86-151.in-addr.btopenworld.com ([81.130.86.151]:44674
	"EHLO lkcl.net") by vger.kernel.org with ESMTP id S265102AbUAMSUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:20:07 -0500
Date: Tue, 13 Jan 2004 18:20:13 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4 kernel pci hot-swap fails on Acer TM C100
Message-ID: <20040113182013.GH18959@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, thought someone might like to take a look some time at the
pci hot-plug code to cope for "instantaneous" hotplugging.

the acer c100 travelmate has built-in ethernet _and_ wireless,
with a button on the keyboard that hot-swaps the PCI bus between
the two devices.

the first device is an rtl8139, the second device is a 3.3v
texas instruments PCMCIA chip with an orinoco hermes 802.11b
wireless behind that.

whilst the PCI devices change, pretty much instantly when
the button is pressed, the IRQ doesn't.

thought someone might like to know, because hot-swapping between
the rtl8139 and the hermes devices definitely doesn't work: the
kernel must be started with one or the other.

swapping back doesn't work either [pressing the button twice]:
if swapping from rtl8139 to hermes and back you get ethernet
timeout messages.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
then expecting someone to call you (and to be able to call you).
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

