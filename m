Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280969AbRKOSMr>; Thu, 15 Nov 2001 13:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRKOSMh>; Thu, 15 Nov 2001 13:12:37 -0500
Received: from ppp-89-100.21-151.libero.it ([151.21.100.89]:6916 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S280969AbRKOSMY>; Thu, 15 Nov 2001 13:12:24 -0500
Date: Thu, 15 Nov 2001 20:11:46 +0100
From: Daniele Venzano <venza@iol.it>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: Problem with i820 AGP patch
Message-ID: <20011115201146.A1279@renditai.milesteg.arr>
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr> <3BF37672.50006@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF37672.50006@epfl.ch>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 09:01:54AM +0100, Nicolas Aspert wrote:
> test... Can you send what 'lspci -ev' shows ?

Here it is, I think I should have thought before...
-ev didn't worked, I used -vn with a cut & paste for names (first line
of each entry)

00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
00:00.0 Class 0600: 8086:2501 (rev 03)
	Subsystem: 1043:801c
	Flags: bus master, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 03) (prog-if 00 [Normal decode])
00:01.0 Class 0604: 8086:250f (rev 03)
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: cc000000-ccffffff
	Prefetchable memory behind bridge: cdf00000-cfffffff

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
00:1e.0 Class 0604: 8086:2418 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Prefetchable memory behind bridge: cd000000-cdefffff

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
01:00.0 Class 0300: 102b:0525 (rev 04)
	Subsystem: 102b:0378
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at ce000000 (32-bit, prefetchable) [size=32M]
	Memory at cc800000 (32-bit, non-prefetchable) [size=16K]
	Memory at cc000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at cdff0000 [disabled] [size=64K]
	Capabilities: <available only to root>

Other entries are all related to non-interesting (I think) devices (IDE, SMBus, audio, etc.)

> It worked, but in which way ? Did you test X+OpenGL apps to see whether 
> it did the trick ? The fact that the module loads itself is not always 
> sufficient to say that it works (believe me :-)
It loaded and glxgears worked correctly, I didn't tested other apps

> With your custom patch, or with the 'generic' stuff ?
Both (sigh!), the problem shows with or without your patch.
Now I'm tring your new patch, but I don't think something will change.

Regards.

-- 
-----------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net

