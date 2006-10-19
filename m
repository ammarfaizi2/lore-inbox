Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWJSNLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWJSNLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWJSNLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:11:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41105 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751591AbWJSNLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:11:55 -0400
Subject: Re: kernel oops with extended serial stuff turned on...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Kilau, Scott" <Scott_Kilau@digi.com>, Greg KH <greg@kroah.com>,
       Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <45373F2F.90906@gmail.com>
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com>
	 <20061018230939.GA7713@kroah.com>
	 <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
	 <45373F2F.90906@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 14:14:16 +0100
Message-Id: <1161263657.17335.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 11:02 +0200, ysgrifennodd Jiri Slaby:
> drivers/char/mxser.c:   mxvar_sdriver->name = "ttyM";
> drivers/char/isicom.c:  isicom_normal->name = "ttyM";

mxser should be ttyMI 0...127

> drivers/char/amiserial.c:       serial_driver->name = "ttyS";
> drivers/char/serial167.c:    cy_serial_driver->name = "ttyS";
> drivers/char/vme_scc.c: scc_driver->name = "ttyS";

Different platform specific drivers - OK

> drivers/char/istallion.c:static char    *stli_serialname = "ttyE";
> drivers/char/stallion.c:        stl_serial->name = "ttyE";

E is assigned to stallion so both seem to share it

> drivers/char/vt.c:      console_driver->name = "tty";
> drivers/char/viocons.c: viotty_driver->name = "tty";

These are correct (different platforms)

Alan

