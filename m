Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSBMSSe>; Wed, 13 Feb 2002 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSBMSS0>; Wed, 13 Feb 2002 13:18:26 -0500
Received: from moutng1.kundenserver.de ([212.227.126.171]:61632 "EHLO
	moutng1.schlund.de") by vger.kernel.org with ESMTP
	id <S288255AbSBMSSO>; Wed, 13 Feb 2002 13:18:14 -0500
Date: Wed, 13 Feb 2002 19:16:51 +0100
From: Nils Faerber <nils@kernelconcepts.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17[16] USB problem
Message-Id: <20020213191651.5c3dfd5e.nils@kernelconcepts.de>
Organization: kernel concepts
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
I recently see a strange USB problem which I find in 2.4.17 and 2.4.16 and
maybe even earlier.
What happens is that a special device attached via a USB HUB is not
detected anymore, specifically usb.c claims that it cannot set the new
address.
The strange thing is:
- It worked with that device (Brainboxes Bluetooth USB dongle) with
earlier kernels.
- The device works when directly connected (and not via extra HUB).
- hub.c tells me that it HAS successfully assigned a new address to that
device!
- And above all, only that special device is affected. All other devices I
have to test (USB mouse and USB webcam) work perfectly.

The error messages also show a strange behaviour of the Linux USB system:
Why does hub.c set the address and then usb.c tries the same again?

I am sure not I am not suffering the earlier mentioned "device not
accepting new address" problem due to interrupt routing problems (since
all other devices work and the machine I am using is a UP notebook).
And I am also sure that this device used to work connected to the HUB with
earlier USB releases.

So please if anyone has new insights on this problem please CC me since I
am not subscribed to lkml...
Many thanks in advance!
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
