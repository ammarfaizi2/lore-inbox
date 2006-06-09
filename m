Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWFIBnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWFIBnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWFIBnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:43:33 -0400
Received: from proof.pobox.com ([207.106.133.28]:48257 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751091AbWFIBnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:43:32 -0400
Date: Thu, 8 Jun 2006 18:43:25 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rahul@genebrew.com, ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: booting without initrd
Message-Id: <20060608184325.5c470dcf.paul@permanentmail.com>
In-Reply-To: <1149813659.3124.31.camel@laptopd505.fenrus.org>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
	<b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
	<1149813659.3124.31.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 02:40:59 +0200, Arjan van de Ven wrote:

> On Thu, 2006-06-08 at 13:40 -0400, Rahul Karnik wrote:
> > On 6/7/06, Ram Gupta <ram.gupta5@gmail.com> wrote:
> > > I am trying to boot with 2.6.16  kernel at my desktop running fedora
> > > core 4 . It does not boot without initrd generating the message "VFS:
> > > can not open device "804" or unknown-block(8,4)
> > > Please append a correct "root=" boot option
> > > Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)
> > 
> > AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
> > grub.conf and therefore needs the initrd in order to work correctly.
> > If you do not want an initrd, then change this to
> > "root=/dev/<your_disk>" in grub.conf. 
> 
> it's more than that; also udev is used from the initrd to populate a
> ramfs /dev, if you go without the initrd you need to populate the
> *real* /dev manually first

Looking through my rc.sysinit (pre-fc6), udev gets started after root is
mounted (I haven't looked at the initrd).

More than likely, something isn't compiled into the kernel (either left
as a module or left out entirely) that is required to access the root
volume.  Without the initrd, no modules can be loaded nor lvm started to
find the root volume.

Where is your root volume and which filesystem are you using.

	-Paul

