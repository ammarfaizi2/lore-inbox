Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129918AbRBAPvl>; Thu, 1 Feb 2001 10:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbRBAPvb>; Thu, 1 Feb 2001 10:51:31 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:9990 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S129918AbRBAPvT>; Thu, 1 Feb 2001 10:51:19 -0500
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, pellicci@home.com,
        Markus.Kuhn@cl.cam.ac.uk, R.A.Reitsma@wbmt.tudelft.nl
Subject: RE: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <4987.980895146@ocs3.ocs-net>
	<NCBBIEBKAIAPGJDGPNCJOENCCFAA.R.A.Reitsma@wbmt.tudelft.nl>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010201165058B.siemer@panorama.hadiko.de>
Date: Thu, 01 Feb 2001 16:50:58 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Miles Lane <miles@megapath.net> wrote:
> >>depmod: *** Unresolved symbols in
> >>/lib/modules/2.4.1/kernel/drivers/media/radio/radio-miropcm20.o
> >>depmod: 	aci_write_cmd
> >>depmod: 	aci_indexed_cmd
> >>depmod: 	aci_write_cmd_d

I made up an new patch for 2.4.1. You can find it on
http://www.uni-karlsruhe.de/~Robert.Siemer/Private/

It works when:
a)  aci: module    miropcm20: module
b)  aci: build in  miropcm20: module
c)  aci: build in  miropcm20: build in

Violation to this table is still unchecked...

Arjan, I want to include your #ifdef solution, but was unable to find
it in 2.2.18... - And further: why did it remove somebody in 2.3.x?

Also (at least) in the case of c) videodev_init() is called twice. -
It does not hurt, but maybe someone can give me a hint why this
happens...


Ciao,
	Robert

PS: Miles email address (miles@megapath.net) is invalid, isn't it?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
