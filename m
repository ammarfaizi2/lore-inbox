Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSBMWmd>; Wed, 13 Feb 2002 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289053AbSBMWmY>; Wed, 13 Feb 2002 17:42:24 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:7176 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S289047AbSBMWmO>; Wed, 13 Feb 2002 17:42:14 -0500
Date: Wed, 13 Feb 2002 23:41:05 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
To: Nils Faerber <nils@kernelconcepts.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17[16] USB problem
In-Reply-To: <20020213191651.5c3dfd5e.nils@kernelconcepts.de>
Message-ID: <Pine.LNX.4.21.0202132335360.1462-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Nils Faerber wrote:

> What happens is that a special device attached via a USB HUB is not
> detected anymore, specifically usb.c claims that it cannot set the new
> address.
> The strange thing is:
> - It worked with that device (Brainboxes Bluetooth USB dongle) with
> earlier kernels.

Is this a buspowered device and if so, how much power does this drain from
the USB? I'm asking because I've just solved (kind of) a similar issue
with a 400mA device when I introduced the missing
connect-detect-to-port-reset debounce delay.

> The error messages also show a strange behaviour of the Linux USB system:
> Why does hub.c set the address and then usb.c tries the same again?

hub.c selects the address and calls usb_new_device from usb.c, which sets
(applies) the new address.

Martin

