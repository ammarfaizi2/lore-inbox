Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279990AbRKDNtC>; Sun, 4 Nov 2001 08:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279991AbRKDNsv>; Sun, 4 Nov 2001 08:48:51 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:22915 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279990AbRKDNsm>; Sun, 4 Nov 2001 08:48:42 -0500
Message-ID: <3BE54731.FC9437CE@mandrakesoft.com>
Date: Sun, 04 Nov 2001 08:48:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Middleditch <elanthis@awesomeplay.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via Onboard Audio - Round #2
In-Reply-To: <1004849558.457.15.camel@stargrazer> 
		<3BE4CC20.5FFEC4B5@mandrakesoft.com> <1004851818.457.24.camel@stargrazer>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Middleditch wrote:
> drivers can handle it.  This is a limitation and/or problem with Linux
> and it's Via Audio driver.  How can I get around this, or do I need to
> reinstall WindowsXP to use the audio?

This has absolutely nothing to do with the audio driver.

Linux is having trouble with your PCI IRQ routing table that is
presented by your BIOS to Linux.

Can you provide 'dmesg -s 16384' output, after changing line 7 of
arch/i386/kernel/pci-i386.h thusly:
-#undef DEBUG
+#define DEBUG 1

This will show me your PCI IRQ routing table.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

