Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131818AbQLPVSN>; Sat, 16 Dec 2000 16:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132236AbQLPVRx>; Sat, 16 Dec 2000 16:17:53 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:20054
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131818AbQLPVRm>; Sat, 16 Dec 2000 16:17:42 -0500
Date: Sat, 16 Dec 2000 21:47:09 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: fritz@isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/isdn/isdn_bsdcomp.c can only be modular (240t13p2)
Message-ID: <20001216214709.C609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

drivers/isdn/isdn_bsdcomp.c #errors if it is not compiled as a module. The
following patch moves this into the Config.in file. Other options include
fixing the code or just noting this in the help option for the config entry.
I leave this up to the maintainers.


--- linux-240-t13-pre2-clean/drivers/isdn/Config.in	Sat Dec 16 20:40:56 2000
+++ linux/drivers/isdn/Config.in	Sat Dec 16 21:40:25 2000
@@ -6,7 +6,7 @@
    if [ "$CONFIG_ISDN_PPP" != "n" ]; then
       bool     '    Use VJ-compression with synchronous PPP' CONFIG_ISDN_PPP_VJ
       bool     '    Support generic MP (RFC 1717)' CONFIG_ISDN_MPP
-      tristate '    Support BSD compression with sync PPP' CONFIG_ISDN_PPP_BSDCOMP
+      dep_tristate '    Support BSD compression with sync PPP' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_MODULES
    fi
 fi
 bool '  Support audio via ISDN' CONFIG_ISDN_AUDIO

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

While the Melissa license is a bit unclear, Melissa aggressively
encourages free distribution of its source code.
  -- Kevin Dalley on Melissa being Open Source
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
