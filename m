Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCTRGc>; Tue, 20 Mar 2001 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCTRGX>; Tue, 20 Mar 2001 12:06:23 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:13769 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S130552AbRCTRGG>; Tue, 20 Mar 2001 12:06:06 -0500
Message-ID: <3AB78CC5.E6D8E748@oracle.com>
Date: Tue, 20 Mar 2001 18:00:53 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pau <linuxnow@terra.es>
CC: lkml <linux-kernel@vger.kernel.org>, jgarzik@mandrakesoft.com
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <Pine.LNX.4.33.0103201753590.1701-100000@pau.intranet.ct>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pau wrote:
> 
> On Tue, 20 Mar 2001, Linus Torvalds wrote:
> 
> >
> >
> > On Tue, 20 Mar 2001, Alessandro Suardi wrote:
> > >
> > >  2.4.3-pre3 and synced-up versions of the -ac series remove support for
> > >  PCMCIA serial CardBus. In drivers/char/pcmcia the Makefile and Config.in
> > >  files are modified to exclude serial_cb and the serial_cb.c file itself
> > >  is removed by the patch. As a net result, my Xircom modem port becomes
> > >  invisible to the kernel and I can't dial out through it.
> >
> > The regular serial.c should handle it natively. Just make sure you have
> > CONFIG_SERIAL enabled, along with hotplugging support etc.
> 
> In fact it does. I discovered it last weekend when my modem -them same one
> than Alessandro's- stopped working.
> 
> Removing "alias char-major-4 serial_cb" from modules.conf did the trick
> and the serial driver worked flawlessly. Modules serial got loaded
> instead.

Cool... but I have used for a while serial_cb in kernel, not as a module
 so there is nothing to remove here :) as for Jeff's surprise I have had
 basically no problem in using kernel PCMCIA stuff in 2.4 series, apart
 from the usual Tx hang bug of the Xircom.

Built with Jeff's latest patch, rebooting....

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p4 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
