Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272696AbRILID4>; Wed, 12 Sep 2001 04:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272695AbRILIDr>; Wed, 12 Sep 2001 04:03:47 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:65524 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S272693AbRILIDk>; Wed, 12 Sep 2001 04:03:40 -0400
Message-ID: <3B9F1670.79952826@tac.ch>
Date: Wed, 12 Sep 2001 10:01:52 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20pre10
In-Reply-To: <E15gwc5-0003VR-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> If you know any reason this should not be 2.2.20 final now is a very very
> good time to say. I intend to call this patch 2.2.20 in a week or so barring
> any last minute problems. Please save anything but actual bugfixes for
> 2.2.21.

Could you please include following patch to your tree? I need this because
we deploy machines with more then 16 interfaces. It's not a problem for me
to patch the kernel but a patch less to carry on each new kernel release is
something less to be able to forget. I know, it's not an actual bugfix but
it's also nothing to worry about since it definitely doesn't break anything
nor unnecessary bloats the kernel.

--- linux-2.2.20pre10/drivers/net/net_init.c	Wed Sep 12 09:39:15 2001
+++ linux-2.2.20pre10-ratz/drivers/net/net_init.c	Wed Sep 12 09:44:11 2001@@
-62,7 +62,7 @@
 */
 
 /* The list of used and available "eth" slots (for "eth0", "eth1", etc.) */
-#define MAX_ETH_CARDS 16
+#define MAX_ETH_CARDS 32
 static struct device *ethdev_index[MAX_ETH_CARDS];

Regards and thanks for including the starfire.c changes from Ion,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
