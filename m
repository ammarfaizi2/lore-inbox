Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267587AbSLFVZQ>; Fri, 6 Dec 2002 16:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbSLFVZQ>; Fri, 6 Dec 2002 16:25:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267587AbSLFVZP>;
	Fri, 6 Dec 2002 16:25:15 -0500
Date: Fri, 6 Dec 2002 15:13:08 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/pci deprecation?
Message-ID: <Pine.LNX.4.33.0212061506060.1010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ISTR /proc/pci being deprecated at one point in the past. It may have only
been discussed, though. In which case, is it possible to deprecate it?
lscpi(8) is considered a superior means to derive the same information.

Elimination of it would eliminate a chunk of code in drivers/pci/proc.c, 
and obviate the use of struct device::name by the PCI layer. This change 
would probably allow us to remove the name field altogether, since PCI is 
the only code that really relies on it (and only for /proc/pci AFAICT).

Is anything in userspace still relying on /proc/pci? 

	-pat

