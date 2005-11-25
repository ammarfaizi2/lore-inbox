Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVKYTMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVKYTMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVKYTMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:12:38 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:17350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751453AbVKYTMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:12:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=D8xLFLvrFleWE8yH5OIXdgzjZYJCz5OarY6erznGDG42cJH0GQRHj0eWHbTXQU5uygSlwhgRmwdvoeOPy05ntqlh08MkIawy0gN7gjAn6+sPcF7Q64fHFe/AVPHtt8+SNRkgINkd+qevM2zHZ636lWwdc0ZBhesSSOm9uPlLXDg=
Message-ID: <4387621B.20301@gmail.com>
Date: Fri, 25 Nov 2005 20:12:27 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
CC: pavel@ucw.cz, shaohua.li@intel.com, stern@rowland.harvard.edu,
       akpm@osdl.org
Subject: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i tried today's git due to Greg's usb patches,
but they don't work.

i wrote already twice the problem:

Stopping tasks: ==========================|
Freeing memory... done (13146 pages freed)
usbfs 2-2:1.0: no suspend?
Could not suspend device 2-2: error -16
Some devices failed to suspend
Restarting tasks... done

If needed i'll reattach the patch i have (against 2.6.14-rc2 iirc)

lsusb
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 0915:8000 GlobeSpan, Inc.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50)
00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50)
00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP



