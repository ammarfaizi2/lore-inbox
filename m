Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpA5JoO4qOeWiR2uL/+4bOF1qdQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:08:37 +0000
Message-ID: <00bb01c415a4$0e492130$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
To: <Administrator@osdl.org>
Subject: New set of input patches
Date: Mon, 29 Mar 2004 16:39:43 +0100
User-Agent: KMail/1.5.4
Content-Class: urn:content-classes:message
Importance: normal
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:43.0875 (UTC) FILETIME=[0EB48D30:01C415A4]

Hi Vojtech,

I have a new set of input patches, could you take look at them?

1. i8042-suspend.patch
   Add suspend methods to i8042 to restore BIOS settings on suspend and
   kill polling timer which sometimes prevents APM suspend

2. i8042-options-parsing.patch
   psmouse-options-parsing.patch
   atkbd-options.parsing
   Complete conversion to the new way of parsing parameters. Drop "i8042_",
   "psmouse_" and "atkbd_" prefixes from option names when compiled as a
   module and require "i8042.", "psmouse." and "atkbd." prefixes if built
   into the kernel.

3. missing-module-license.patch
   Maple and newton keyboard drivers were missing MODULE_LICENSE("GPL")

4. kconfig-synaptics-help.patch
   Suggest psmouse.proto=imps to Synaptics users who do not want install
   native XFree Synaptics driver so taps would still work

5. sis-aux-port.patch
   Do not ignore AUX port if chipset fails to disable it when we do probes
   as SiS is having trouble disabling but otherwise mouse works fine.

The patches are on top of 2 other input patches (remove jitter and ps2
emulation) that I have sent to the list earlier. You can find the complete
set of patches at http://www.geocities.com/dt_or/input/2_6_0-rc1/ and
http://www.geocities.com/dt_or/input/2_6_0-rc1-mm1/

Dmitry
