Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbSKKNDu>; Mon, 11 Nov 2002 08:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265006AbSKKNDu>; Mon, 11 Nov 2002 08:03:50 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:61135 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S265003AbSKKNDt>;
	Mon, 11 Nov 2002 08:03:49 -0500
Date: Mon, 11 Nov 2002 14:10:36 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: "Filipau, Ihar" <ifilipau@sussdd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: [linux-usb-devel] boot from usb storage
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF9065048@CHARLY>
Message-ID: <Pine.LNX.4.44.0211111406080.11999-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Nov 2002, Filipau, Ihar wrote:
> 	In short:
> 	Is it possible to boot from portable USB DVD drive?
> 	Is this supported in BIOSes?

Don't know.

> 	Will kernel be able to find a root?

Normally it doesn't work because USB devices are detectly
asynchronously (from a kernel thread). At the time a USB device is
discovered, the root mounting code has already given up.

I have a patch to fix this at
http://www.lammerts.org/software/kernelpatches/usb-storage-root.patch
It's tested only with USB harddisks, but will probably also work with
DVD drives.

Eric


