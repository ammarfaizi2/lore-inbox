Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVKAIRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVKAIRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVKAIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:17:49 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:48621 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965077AbVKAIR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:17:28 -0500
Message-ID: <4367246F.1080802@m1k.net>
Date: Tue, 01 Nov 2005 03:16:47 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 37/37] dvb: documentation updates for hybrid v4l/dvb cards.
Content-Type: multipart/mixed;
 boundary="------------030002000103090803010009"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002000103090803010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------030002000103090803010009
Content-Type: text/x-patch;
 name="2415.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2415.patch"

Updated documentation to include "hybrid" v4l/dvb and ATSC cards.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 Documentation/dvb/cards.txt        |   37 +++++++++++++++++++++++++++++++++++++
 Documentation/dvb/contributors.txt |   17 +++++++++++++++++
 2 files changed, 54 insertions(+)

--- linux-2.6.14-git3.orig/Documentation/dvb/cards.txt
+++ linux-2.6.14-git3/Documentation/dvb/cards.txt
@@ -41,6 +41,12 @@
    - dib3000mb	: DiBcom 3000-MB demodulator
   DVB-S/C/T:
    - dst		: TwinHan DST Frontend
+  ATSC:
+   - nxt200x		: Nxtwave NXT2002 & NXT2004
+   - or51211		: or51211 based (pcHDTV HD2000 card)
+   - or51132		: or51132 based (pcHDTV HD3000 card)
+   - bcm3510		: Broadcom BCM3510
+   - lgdt330x		: LG Electronics DT3302 & DT3303
 
 
 o Cards based on the Phillips saa7146 multimedia PCI bridge chip:
@@ -62,6 +68,10 @@
   - Nebula Electronics DigiTV
   - TwinHan DST
   - Avermedia DVB-T
+  - ChainTech digitop DST-1000 DVB-S
+  - pcHDTV HD-2000 TV
+  - DViCO FusionHDTV DVB-T Lite
+  - DViCO FusionHDTV5 Lite
 
 o Technotrend / Hauppauge DVB USB devices:
   - Nova USB
@@ -83,3 +93,30 @@
   - DiBcom USB2.0 DVB-T reference device (non-public)
 
 o Experimental support for the analog module of the Siemens DVB-C PCI card
+
+o Cards based on the Conexant cx2388x PCI bridge:
+  - ADS Tech Instant TV DVB-T PCI
+  - ATI HDTV Wonder
+  - digitalnow DNTV Live! DVB-T
+  - DViCO FusionHDTV DVB-T1
+  - DViCO FusionHDTV DVB-T Plus
+  - DViCO FusionHDTV3 Gold-Q
+  - DViCO FusionHDTV3 Gold-T
+  - DViCO FusionHDTV5 Gold
+  - Hauppauge Nova-T DVB-T
+  - KWorld/VStream XPert DVB-T
+  - pcHDTV HD3000 HDTV
+  - TerraTec Cinergy 1400 DVB-T
+  - WinFast DTV1000-T
+
+o Cards based on the Phillips saa7134 PCI bridge:
+  - Medion 7134
+  - Pinnacle PCTV 300i DVB-T + PAL
+  - LifeView FlyDVB-T DUO
+  - Typhoon DVB-T Duo Digital/Analog Cardbus
+  - Philips TOUGH DVB-T reference design
+  - Philips EUROPA V3 reference design
+  - Compro Videomate DVB-T300
+  - Compro Videomate DVB-T200
+  - AVerMedia AVerTVHD MCE A180
+
--- linux-2.6.14-git3.orig/Documentation/dvb/contributors.txt
+++ linux-2.6.14-git3/Documentation/dvb/contributors.txt
@@ -75,5 +75,22 @@
 Peter Beutner <p.beutner@gmx.net>
   for the IR code for the ttusb-dec driver
 
+Wilson Michaels <wilsonmichaels@earthlink.net>
+  for the lgdt330x frontend driver, and various bugfixes
+
+Michael Krufky <mkrufky@m1k.net>
+  for maintaining v4l/dvb inter-tree dependencies
+
+Taylor Jacob <rtjacob@earthlink.net>
+  for the nxt2002 frontend driver
+
+Jean-Francois Thibert <jeanfrancois@sagetv.com>
+  for the nxt2004 frontend driver
+
+Kirk Lapray <kirk.lapray@gmail.com>
+  for the or51211 and or51132 frontend drivers, and
+  for merging the nxt2002 and nxt2004 modules into a
+  single nxt200x frontend driver.
+
 (If you think you should be in this list, but you are not, drop a
  line to the DVB mailing list)


--------------030002000103090803010009--
