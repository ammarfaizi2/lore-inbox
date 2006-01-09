Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWAIUXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWAIUXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAIUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:23:07 -0500
Received: from mail.linicks.net ([217.204.244.146]:32967 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751312AbWAIUXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:23:05 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: ALSA - pnp OS bios option
Date: Mon, 9 Jan 2006 20:22:56 +0000
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092022.56244.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On New Years eve my CPU (Athlon 1200 ams3b) died.  I managed to get a 
replacement off e-bay.  During my diagnosis of what happened, I reset BIOS, 
so obviously when I got the replacement I had to set it all up again.


Info: 2.6.15, on base Slack 10 (updated a lot from source).

PCI:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] 
(rev a3)



If I turn OFF PNP OS, when I boot, 'alsactl restore' (run from rc.local) 
squinnies:

Set_Control:894 Name mismatch ... Control #47
896: Index mismatch (0/0) for Control #47
1008: Bad control.47.value

Then I messed with alsamixer/aslactl store~restore etc. and all appeared OK in 
console - but sound is all messed as if no restore was done.  And I get the 
same error on boot again.

Turn ON PNP OS in BIOS, and all works again, alsactl restore works fine.

Now, after the issue I had with my CPU dying, I hate keep rebooting to test 
this, but the tests I done appear as above.

So, is this something else?  Or do I need to set PNP OS in BIOS for ALSA?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
