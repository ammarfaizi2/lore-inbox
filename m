Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUKBPKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUKBPKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKBPD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:03:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10683 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262635AbUKBPCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:02:16 -0500
Date: Tue, 2 Nov 2004 10:02:44 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Krzysztof Taraszka <dzimi@pld-linux.org>
cc: Sergey Vlasov <vsu@altlinux.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
In-Reply-To: <200410311053.34927.dzimi@pld-linux.org>
Message-ID: <Pine.LNX.4.44.0411020958460.8117-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 31 Oct 2004, Krzysztof Taraszka wrote:

> Dnia sobota, 30 pa¼dziernika 2004 21:19, napisa³e¶:
> > On Fri, Oct 29, 2004 at 02:29:43PM -0400, Jason Baron wrote:
> 
> > > Here's an updated 2.4 tty patch. I'm not sure if the updated patch would
> > > fix the above issue, but it has a lot of changes so it might be worth a
> > > try.
> >
> > This looks better - at least the system boots without hang or oops ;)
> 
> where is an updated 2.4 tty patch ?
> 
> 

hmmm...seems like my e-mails keeping getting dropped, perhaps the patch is
too large? Here is a link to the patch:

http://people.redhat.com/~jbaron/tty/2.4-tty-V5.patch

-Jason

 linux-2.4.28-rc1-tty/drivers/char/n_r3964.c               |    3 
 linux-2.4.28-rc1-tty/Documentation/tty.txt                |  194 ++++
 linux-2.4.28-rc1-tty/drivers/bluetooth/hci_ldisc.c        |    8 
 linux-2.4.28-rc1-tty/drivers/char/amiserial.c             |   12 
 linux-2.4.28-rc1-tty/drivers/char/cyclades.c              |   14 
 linux-2.4.28-rc1-tty/drivers/char/dz.c                    |    4 
 linux-2.4.28-rc1-tty/drivers/char/epca.c                  |   27 
 linux-2.4.28-rc1-tty/drivers/char/esp.c                   |   13 
 linux-2.4.28-rc1-tty/drivers/char/generic_serial.c        |   15 
 linux-2.4.28-rc1-tty/drivers/char/hvc_console.c           |    5 
 linux-2.4.28-rc1-tty/drivers/char/isicom.c                |   14 
 linux-2.4.28-rc1-tty/drivers/char/moxa.c                  |   16 
 linux-2.4.28-rc1-tty/drivers/char/mxser.c                 |   13 
 linux-2.4.28-rc1-tty/drivers/char/n_tty.c                 |  331 ++++++-
 linux-2.4.28-rc1-tty/drivers/char/pcmcia/synclink_cs.c    |   59 -
 linux-2.4.28-rc1-tty/drivers/char/pcxx.c                  |   36 
 linux-2.4.28-rc1-tty/drivers/char/pty.c                   |    9 
 linux-2.4.28-rc1-tty/drivers/char/riscom8.c               |   12 
 linux-2.4.28-rc1-tty/drivers/char/rocket.c                |   26 
 linux-2.4.28-rc1-tty/drivers/char/selection.c             |    4 
 linux-2.4.28-rc1-tty/drivers/char/ser_a2232.c             |    5 
 linux-2.4.28-rc1-tty/drivers/char/serial.c                |   21 
 linux-2.4.28-rc1-tty/drivers/char/serial167.c             |   21 
 linux-2.4.28-rc1-tty/drivers/char/serial_tx3912.c         |    5 
 linux-2.4.28-rc1-tty/drivers/char/sgiserial.c             |    4 
 linux-2.4.28-rc1-tty/drivers/char/specialix.c             |   15 
 linux-2.4.28-rc1-tty/drivers/char/stallion.c              |   13 
 linux-2.4.28-rc1-tty/drivers/char/sx.c                    |    4 
 linux-2.4.28-rc1-tty/drivers/char/synclink.c              |   64 -
 linux-2.4.28-rc1-tty/drivers/char/synclinkmp.c            |   49 -
 linux-2.4.28-rc1-tty/drivers/char/tty_io.c                |  587 +++++++++++---
 linux-2.4.28-rc1-tty/drivers/char/tty_ioctl.c             |   60 +
 linux-2.4.28-rc1-tty/drivers/char/vme_scc.c               |    8 
 linux-2.4.28-rc1-tty/drivers/char/vt.c                    |    3 
 linux-2.4.28-rc1-tty/drivers/macintosh/macserial.c        |   11 
 linux-2.4.28-rc1-tty/drivers/net/ppp_async.c              |   31 
 linux-2.4.28-rc1-tty/drivers/net/ppp_synctty.c            |   15 
 linux-2.4.28-rc1-tty/drivers/net/slip.c                   |   20 
 linux-2.4.28-rc1-tty/drivers/net/wan/pc300_tty.c          |   34 
 linux-2.4.28-rc1-tty/drivers/net/wan/sdla_chdlc.c         |   19 
 linux-2.4.28-rc1-tty/drivers/s390/char/con3215.c          |   10 
 linux-2.4.28-rc1-tty/drivers/sbus/char/aurora.c           |   15 
 linux-2.4.28-rc1-tty/drivers/sbus/char/zs.c               |    4 
 linux-2.4.28-rc1-tty/drivers/tc/zs.c                      |   13 
 linux-2.4.28-rc1-tty/drivers/usb/serial/digi_acceleport.c |   12 
 linux-2.4.28-rc1-tty/drivers/usb/serial/io_edgeport.c     |    7 
 linux-2.4.28-rc1-tty/drivers/usb/serial/io_ti.c           |    7 
 linux-2.4.28-rc1-tty/drivers/usb/serial/keyspan_pda.c     |    8 
 linux-2.4.28-rc1-tty/drivers/usb/serial/mct_u232.c        |    6 
 linux-2.4.28-rc1-tty/fs/proc/proc_tty.c                   |   11 
 linux-2.4.28-rc1-tty/include/linux/tty.h                  |   41 
 linux-2.4.28-rc1-tty/include/linux/tty_ldisc.h            |    9 
 52 files changed, 1368 insertions(+), 579 deletions(-)

