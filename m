Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293411AbSBYTV7>; Mon, 25 Feb 2002 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293429AbSBYTVt>; Mon, 25 Feb 2002 14:21:49 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:43177 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293411AbSBYTVn>; Mon, 25 Feb 2002 14:21:43 -0500
Message-Id: <200202251832.LAA20849@tstac.esa.lanl.gov>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Pete Zaitcev <zaitcev@redhat.com>, marcelo@conectiva.com.br
Subject: Re: Patch for YMFPCI Configure.help
Date: Mon, 25 Feb 2002 12:18:33 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, ddcarpen1@cs.bemidjistate.edu,
        Dave Jones <davej@suse.de>
In-Reply-To: <20020225125238.A15611@devserv.devel.redhat.com>
In-Reply-To: <20020225125238.A15611@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 February 2002 10:52 am, Pete Zaitcev wrote:
> The Configure.help entry was completely bogus. Sorry.
> Please give credit to Dan D. Carpenter in the changelog.
>
> -- Pete
>
> --- linux-2.4.18-rc2/Documentation/Configure.help	Tue Feb 19 16:12:05 2002
> +++ linux-2.4.18-rc2-p3/Documentation/Configure.help	Mon Feb 25 09:49:03
> 2002 @@ -18943,8 +18943,11 @@
>
>  Yamaha YMF7xx PCI audio (native mode)
>  CONFIG_SOUND_YMFPCI
> -  Support for Yamaha cards including the YMF711, YMF715, YMF718,
> -  YMF719, YMF724, Waveforce 192XG, and Waveforce 192 Digital.
> +  Support for Yamaha cards with the following chipsets: YMF724,
> +  YMF724F, YMF740, YMF740C, YMF744, and YMF754.
> +
> +  Two common cards that use this type of chip are Waveforce 192XG,
> +  and Waveforce 192 Digital.
>
>  Yamaha PCI legacy ports support
>  CONFIG_SOUND_YMFPCI_LEGACY
> -

Good, and to keep 2.5.x up to date and accurate, here is the corresponding
patch for sound/oss/Config.help, made against 2.5.5-dj1:

Steven

--- linux-2.5.5-dj1/sound/oss/Config.help.orig  Mon Feb 25 12:05:05 2002
+++ linux-2.5.5-dj1/sound/oss/Config.help       Mon Feb 25 12:09:18 2002
@@ -696,8 +696,11 @@
   Support for MIDI loopback on port 1 or 2.

 CONFIG_SOUND_YMFPCI
-  Support for Yamaha cards including the YMF711, YMF715, YMF718,
-  YMF719, YMF724, Waveforce 192XG, and Waveforce 192 Digital.
+  Support for Yamaha cards with the following chipsets: YMF724,
+  YMF724F, YMF740, YMF740C, YMF744, and YMF754.
+
+  Two common cards that use this type of chip are Waveforce 192XG,
+  and Waveforce 192 Digital.

 CONFIG_SOUND_YMFPCI_LEGACY
   Support for YMF7xx PCI cards emulating an MP401.

