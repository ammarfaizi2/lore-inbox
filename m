Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUHVM1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUHVM1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUHVM1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:27:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42894 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266704AbUHVM1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:27:33 -0400
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093173914.24272.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 12:25:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-21 at 10:09, Piotr Goczal wrote:
> With old version of SX6000 firmware (Bios version 1.1.0 (Build 15), 
> Firmware 77RM) driver's found controler but it's hanging durring 
> initialisation.

It will pause during initialization with older firmware and it tends to
spew a few messages because Promise interpretation of the I2O spec is
somewhat different to other devices, as well as including some clear
mistakes

> With new version of firmware (Bios version 1.20.0.27) driver doesn't 
> recognise hardware at all. The problem is: Promise's changed PCI_CLASS 
> identifier from 0x0e00 (I2O controler) to 0x0104 (RAID bus controller). 
> I've tried simply change PCI_CLASS number in source and recompile it but 
> it doesn't work good (driver recognised hardware but hung whole machine!).

The new firmware isn't I2O any more. I've not found any public docs on
the newer firmware interface and since it was way slower than the 3ware
card I never looked.

Alan

