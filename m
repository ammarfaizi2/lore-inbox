Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291854AbSBNTzS>; Thu, 14 Feb 2002 14:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291859AbSBNTzI>; Thu, 14 Feb 2002 14:55:08 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:57160 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291854AbSBNTy4>; Thu, 14 Feb 2002 14:54:56 -0500
Date: Thu, 14 Feb 2002 14:54:54 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: John Weber <john.weber@linuxhq.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] YMFPCI Patches
Message-ID: <20020214145454.A23902@devserv.devel.redhat.com>
In-Reply-To: <3C6BDE9A.4070906@linuxhq.com> <20020214125904.A2591@devserv.devel.redhat.com> <3C6C12DC.7030406@linuxhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6C12DC.7030406@linuxhq.com>; from john.weber@linuxhq.com on Thu, Feb 14, 2002 at 02:41:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 14 Feb 2002 14:41:16 -0500
> From: John Weber <john.weber@linuxhq.com>

> >>Here's a patch (against 2.5.4) that makes a little change to 
> >>sound/Config.in that makes my kernel link (and my YMF sound work :).
> > 
> > Your mailer corrupted both of them
> 
> I am using Mozilla, so I don't know what it did to the patches.
> I've sent them as attachments this time.

OK, I approve, but honestly, I do not care much for 2.5.
If Linus applies, fine. If not - fine too. ALSA makes it pretty
irrelevant anyhow... And I am happy to discard the maintainer's
mantle. Let the penguin insult some other sucker.

-- Pete

P.S. Un-MIMEd patch

--- linux-2.5.4/sound/oss/Config.in	Thu Feb 14 11:00:32 2002
+++ linux-2.5.5/sound/oss/Config.in	Thu Feb 14 11:01:46 2002
@@ -103,6 +103,9 @@
 dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
 dep_mbool    '  VIA 82C686 MIDI' CONFIG_MIDI_VIA82CXXX $CONFIG_SOUND_VIA82CXXX
 
+dep_tristate '  Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_PCI
+dep_mbool '    Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
+
 dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND
 
 if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
@@ -164,8 +167,6 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   dep_mbool '      Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS
   
    dep_tristate '    Gallant Audio Cards (SC-6000 and SC-6600 based)' CONFIG_SOUND_AEDSP16 $CONFIG_SOUND_OSS

