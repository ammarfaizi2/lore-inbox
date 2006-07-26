Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWGZA0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGZA0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGZA0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:26:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9689 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S932508AbWGZA0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:26:45 -0400
Subject: Re: Rescan IDE interface when no IDE devices are present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel De Graaf <danieldegraaf@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
References: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
	 <1153077903.5905.35.camel@localhost.localdomain>
	 <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 02:28:24 +0100
Message-Id: <1153877304.7559.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-07-16 at 15:03 -0500, Daniel De Graaf wrote:
> On 7/16/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > If you have ide1, you have both hdc and hdd (slave of hdc) unles sit's
> > not really IDE ...
> >
> > Ben.
> 
> Yes, I have /dev/hdd, but no device is ever present there. I also have
> /dev/sda for the SATA hard disk, but do not think it is useful for
> HDIO_SCAN_HWIF or HWIO_UNREGISTER_HWIF ioctls.

There isn't. Feel free to write a module to do it (see how the ioctl
handles it and follow the same logic). Its at best a hack. libata is
trying to add proper hotplug for ATA/SATA.

Alan
