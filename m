Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270731AbTGUVnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270734AbTGUVnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:43:11 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:33970 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S270731AbTGUVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:43:08 -0400
Subject: Re: 2.4.22pre7aa1: net/bluetooth/cmtp/core.c failure
From: Marcel Holtmann <marcel@holtmann.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1A5214.CEF2913A@eyal.emu.id.au>
References: <20030719013223.GA31330@dualathlon.random> 
	<3F1A5214.CEF2913A@eyal.emu.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Jul 2003 23:57:04 +0200
Message-Id: <1058824632.24435.8.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eyal,

> > URL:
> > 
> >         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1.bz2
> >         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1/
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=4 -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=core  -c -o core.o
> core.c
> core.c: In function `cmtp_session':
> core.c:301: structure has no member named `nice'
> make[3]: *** [core.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/net/bluetooth/cmtp'

this line

	current->nice = -15;

must be replaced with this

	set_user_nice(current, -15);

And this is not a problem of the 2.4.22-pre7, it is a fault in aa1 only.

Regards

Marcel


