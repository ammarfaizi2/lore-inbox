Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTIHP3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTIHP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:49033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262697AbTIHP21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:28:27 -0400
Message-ID: <32829.4.4.25.4.1063034905.squirrel@www.osdl.org>
Date: Mon, 8 Sep 2003 08:28:25 -0700 (PDT)
Subject: Re: USB error numbers
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <root@mauve.demon.co.uk>
In-Reply-To: <200309081221.NAA21943@mauve.demon.co.uk>
References: <200309081221.NAA21943@mauve.demon.co.uk>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where do the various numbers come from in messages such as
> USB device not accepting new address=5 (error=-110), and what do they
> "mean"?
> I'm trying to work out why this happens when I plug in one of several
> webcams (into any of several computers) and one webcam occasionally. -

Hm, the USB error numbers are listed/documented in
linux/Documentation/usb/error-codes.txt (by name).

Look in include/<asm-arch>/errno.h to match names to values
(or include/asm-generic/errno.h).

-110 for x86 is -ETIMEDOUT (USB returns negative error numbers).
It can mean that the device just wasn't responding, or it can mean
that there is a problem with USB interrupt routing.  There is lots
of work going on in this area right now, especially related to ACPI
interrupt routing.

~Randy




