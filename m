Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310172AbSCFU6E>; Wed, 6 Mar 2002 15:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310178AbSCFU5y>; Wed, 6 Mar 2002 15:57:54 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:41189 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S310172AbSCFU5q>; Wed, 6 Mar 2002 15:57:46 -0500
Message-ID: <3C86827C.873878A3@sandino.net>
Date: Wed, 06 Mar 2002 14:56:28 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net>
		<20020302075847.GE20536@kroah.com>
		<3C84294C.AE1E8CE9@sandino.net> <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

>
> I suspect the USB-UHCI driver is doing a double-unregister on a devfs
> entry.

The usb-storage is using the devfs entries previously registered by the ide-scsi driver, it doesn't create new entries. When the  usb-storage module is
unloaded it unregisters such entries.

> Please set CONFIG_DEVFS_DEBUG=y,

CONFIG_DEVFS_DEBUG=y was already set before passing the trace to ksymoops. If you need me to search into the system log just tellme what to search for.

> recompile and boot the new
> kernel. Send the new Oops (passed through ksymoops, of course).
>
>

> --
> Sandino Araico Sánchez
> >drop table internet;
> OK, 135454265363565609860398636678346496 rows affected.
> "oh fuck" --fluxrad

