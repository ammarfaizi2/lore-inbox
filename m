Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135913AbRDTNYm>; Fri, 20 Apr 2001 09:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135912AbRDTNYc>; Fri, 20 Apr 2001 09:24:32 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:7952 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135913AbRDTNYS>;
	Fri, 20 Apr 2001 09:24:18 -0400
Date: Fri, 20 Apr 2001 09:25:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Documentation fixes
Message-ID: <20010420092507.A5384@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These changes fix some errors in the 2.4.4pre4 documentation and retire 
a few dead symbols in the process.

--- Documentation/kbuild/config-language.txt	2001/04/20 00:40:20	1.1
+++ Documentation/kbuild/config-language.txt	2001/04/20 00:41:09
@@ -349,7 +349,7 @@
     if [ "$CONFIG_ALPHA_GENERIC" = "y" ]
     then
             define_bool CONFIG_PCI y
-            define_bool CONFIG_ALPHA_NEED_ROUNDING_EMULATION y
+            define_bool CONFIG_ALPHA_BROKEN_IRQ_MASK y
     fi
 
 
--- Documentation/sound/MAD16	2001/04/20 00:09:57	1.1
+++ Documentation/sound/MAD16	2001/04/20 00:12:14
@@ -1,3 +1,5 @@
+(This recipe has been edited to update the configuration symbols.)
+
 From: Shaw Carruthers <shaw@shawc.demon.co.uk>
 
 I have been using mad16 sound for some time now with no problems, current
@@ -14,9 +16,9 @@
 .config has:
 
 CONFIG_SOUND=m
-CONFIG_ADLIB=m
-CONFIG_MAD16=m
-CONFIG_YM3812=m
+CONFIG_SOUND_ADLIB=m
+CONFIG_SOUND_MAD16=m
+CONFIG_SOUND_YM3812=m
 
 modules.conf has:
 
--- Documentation/sound/Opti	2001/04/20 00:12:37	1.1
+++ Documentation/sound/Opti	2001/04/20 00:13:57
@@ -29,21 +29,21 @@
 
 Sound card support should be enabled as a module (chose m).
 Answer 'm' for  these items:
-  Generic OPL2/OPL3 FM synthesizer support			(CONFIG_ADLIB)
-  Microsoft Sound System support				(CONFIG_MSS)
-  Support for OPTi MAD16 and/or Mozart based cards	 	(CONFIG_MAD16)
-  FM synthesizer (YM3812/OPL-3) support				(CONFIG_YM3812)
+  Generic OPL2/OPL3 FM synthesizer support		(CONFIG_SOUND_ADLIB)
+  Microsoft Sound System support			(CONFIG_SOUND_MSS)
+  Support for OPTi MAD16 and/or Mozart based cards	(CONFIG_SOUND_MAD16)
+  FM synthesizer (YM3812/OPL-3) support			(CONFIG_SOUND_YM3812)
 
 The configuration menu may ask for addresses, IRQ lines or DMA
 channels. If the card is used as a module the module loading
 options will override these values.
 
 For the OPTi 931 you can answer 'n' to:
-  Support MIDI in older MAD16 based cards (requires SB)		(CONFIG_MAD16_OLDCARD)
+  Support MIDI in older MAD16 based cards (requires SB)	(CONFIG_SOUND_MAD16_OLDCARD)
 If you do need MIDI support in a Mozart or C928 based card you
 need to answer 'm' to the above question. In that case you will
 also need to answer 'm' to:
-  '100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support' (CONFIG_SB)
+  '100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support' (CONFIG_SOUND_SB)
 
 Go on and compile your kernel and modules. Install the modules. Run depmod -a.
 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The whole of the Bill [of Rights] is a declaration of the right of the
people at large or considered as individuals...  It establishes some
rights of the individual as unalienable and which consequently, no
majority has a right to deprive them of.
         -- Albert Gallatin, Oct 7 1789
