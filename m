Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWJ3T5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWJ3T5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWJ3T5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:57:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:22938 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932472AbWJ3T5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:57:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc3-mm1 - ATI SATA controller not detected
Date: Mon, 30 Oct 2006 20:55:18 +0100
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061030035430.GA4045@kroah.com> <20061029211604.41114b13.akpm@osdl.org>
In-Reply-To: <20061029211604.41114b13.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302055.21305.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 30 October 2006 06:16, Andrew Morton wrote:
> On Sun, 29 Oct 2006 19:54:30 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> > > On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> > > 
> > >  > - For some reason Greg has resurrected the patches which detect whether
> > >  >   you're using old versions of udev and if so, punish you for it.
> > >  > 
> > >  >   If weird stuff happens, try upgrading udev.
> > > 
> > > Where "old" is how old exactly ?
> > 
> > As per the Kconfig help entry, any version of udev released before 2006
> > will probably have problems with the new config option.  So follow the
> > text and enable the option if you are running an old version of udev and
> > you should be fine.
> 
> <hunts>
> 
> Greg is referring to CONFIG_SYSFS_DEPRECATED.  I didn't know it existed. 
> If I had known I'd have saved maybe an hour and I perhaps wouldn't have had
> to revert gregkh-driver-tty-device.patch
> 
> What mailing list was this discussed and reviewed on?
> 
> The option should default to "y".

I have this one set, but the kernel apparently fails to find the ATI SATA
controller:

00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
        I/O ports at 9000 [size=8]
        I/O ports at 9008 [size=4]
        I/O ports at 9010 [size=8]
        I/O ports at 7018 [size=4]
        I/O ports at 7020 [size=16]
        Memory at d4409000 (32-bit, non-prefetchable) [size=512]
        [virtual] Expansion ROM at 52000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable

(with 2.6.19-rc2-mm2 and before it was handled by the sata_sil driver).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
