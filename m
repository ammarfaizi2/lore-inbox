Return-Path: <linux-kernel-owner+w=401wt.eu-S1761255AbWLJPhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761255AbWLJPhi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761258AbWLJPhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:37:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:64904 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761255AbWLJPhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:37:37 -0500
Message-ID: <457C29C7.1020009@anagramm.de>
Date: Sun, 10 Dec 2006 16:37:43 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <20061210084453.13702.qmail@science.horizon.com>
In-Reply-To: <20061210084453.13702.qmail@science.horizon.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There!

> Now, I can imagine a USB slave controller so cheap and/or buggy that it
> doesn't check the CRC, but I'd think that most would.  Checking a CRC
> is hardly a novel challenge.

Do we have any counters in the USB Stack and the drivers which count the
USB transaction errors?
According to some datasheets (i.e. NXP ISP1563) there are bits called
USB Error and USB Error Interrupt" etc.
Are those should be implemented / counted in the driver stack somewhere?
Okay, simple question...

A quick look into ehci.h tells me that the bit inside of the kernel
is propably called STS_ERR and is used i.e. in ehci_dbg.c 's 
and printed through dbg_status_buf() and dbg_intr.buf().
Maybe it's sufficient to turn on debugging and turn the
error flag into an error counter just to get an idea if it cumulates?

Just my five cents,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
