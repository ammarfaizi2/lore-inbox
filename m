Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDULrs>; Sat, 21 Apr 2001 07:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDULri>; Sat, 21 Apr 2001 07:47:38 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:44069 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132567AbRDULqg>; Sat, 21 Apr 2001 07:46:36 -0400
Date: Sat, 21 Apr 2001 13:46:08 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
cc: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>,
        I4L Developer List <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: [kbuild-devel] Dead symbol elimination, stage 1
In-Reply-To: <Pine.LNX.4.33.0104192251090.1232-100000@vaio>
Message-ID: <Pine.LNX.4.31.0104211342140.20956-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Kai Germaschewski wrote:
> On Thu, 19 Apr 2001, Eric S. Raymond wrote:
>
> > The following patch cleans dead symbols out of the defconfigs in the 2.4.4pre4
> > source tree.  It corrects a typo involving CONFIG_GEN_RTC.  Another typo
> > involving CONFIG_SOUND_YMPCI doesn't need to be corrected, as the symbol
> > is never set in these files.
>
> While I think your work CONFIG_ cleanup is generally a good idea and will
> remove a lot of cruft, I don't think the defconfigs are worth the effort
> (but maybe I'm missing something).
>
> First, they are only used as defaults, and any inconsistency should get
> cleaned up before the user even sees it.
>
> Second, removing dead entries is not all which is needed to get a
> defconfig which is necessarily consistent. So if you want to have these,
> why don't you do a
>
> 	cp arch/$ARCH/defconfig .config
> 	make oldconfig
>
> AFAICS, this should remove old cruft and provide a .config (to be used as
> defconfig) which is consistent with the current config.in's.
>
>
> Anyway, I put together a patch which should clean up some issues which I
> was reminded of because of your work in the ISDN subsystem. I appended it,
> I hope the maintainer of the Eicon code (Armin) will clean up the missing
> Configure.help entries for his drivers.

Oops, thanks for the hint. I only sent the patch for 2.2.
I appended it for 2.4 and already send it to Linus.

Armin



--- Documentation/Configure.help_orig	Sat Apr 21 13:19:11 2001
+++ Documentation/Configure.help	Sat Apr 21 13:23:55 2001
@@ -15447,11 +15447,16 @@
   latest isdn4k-utils package. Please read the file
   Documentation/isdn/README.eicon for more information.

+Eicon legacy driver
+CONFIG_ISDN_DRV_EICON_OLD
+  Say Y here to use your Eicon active ISDN card with ISDN4Linux
+  isdn module.
+
 Eicon Diva Server card support
 CONFIG_ISDN_DRV_EICON_PCI
   Say Y here if you have an Eicon Diva Server (BRI/PRI/4BRI) ISDN card.
   Please read Documentation/isdn/README.eicon for more information.
-
+
 Eicon old-type card support
 CONFIG_ISDN_DRV_EICON_ISA
   Say Y here if you have an old-type Eicon active ISDN card. In order
@@ -15461,7 +15466,7 @@
   Documentation/isdn/README.eicon for more information.

 Eicon driver type standalone
-CONFIG_ISDN_DRV_EICON_STANDALONE
+CONFIG_ISDN_DRV_EICON_DIVAS
   Enable this option if you want the eicon driver as standalone
   version with no interface to the ISDN4Linux isdn module. If you
   say Y here, the eicon module only supports the Diva Server PCI

