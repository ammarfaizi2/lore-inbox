Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUALH4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 02:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUALH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 02:56:05 -0500
Received: from AGrenoble-101-1-2-83.w193-253.abo.wanadoo.fr ([193.253.227.83]:2989
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266075AbUALH4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 02:56:03 -0500
Subject: Re: 2.6.0: blkdev_get() oopses on floppy
From: Xavier Bestel <xavier.bestel@free.fr>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040112015238.GH30321@parcelfarce.linux.theplanet.co.uk>
References: <1073861431.5014.85.camel@bip.parateam.prv>
	 <20040112015238.GH30321@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073894153.950.19.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 08:55:56 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 12/01/2004 à 02:52, viro@parcelfarce.linux.theplanet.co.uk a
écrit :

> That's wrong - faling blkdev_get() will do bdput() itself.

Ok, thanks (strange). But note that my problem is at blkdev_get() time.

> *NOTE*:  unless you are really forced to, don't use that "open by device
> number" crap at all - normal filp_open() will do nicely if you have the
> pathname of device in question and it's _much_ better interface.

But that's exactely what raw.c does (although the userspace knows the
dev pathname).

> > raw /dev/raw/raw1 /dev/fd0
> > cat /dev/raw/raw1 >/dev/null
> > 
> > and got this oops:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000040
[...]
> Lovely...  Which kernel is that?

Plain 2.6.0, I'll try 2.6.1 when I can.

Thanks Al,

	Xav

