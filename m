Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTKJQZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTKJQZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:25:30 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:28369 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263963AbTKJQZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:25:27 -0500
Subject: RE: problem in booting HP zx6000 with stock kernel 2.5.75
From: Alex Williamson <alex.williamson@hp.com>
To: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <1B3885BC15C7024C845AAC78314766C5A26B55@EXCH-01>
References: <1B3885BC15C7024C845AAC78314766C5A26B55@EXCH-01>
Content-Type: text/plain
Message-Id: <1068481003.1144.22.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 Nov 2003 09:16:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-09 at 22:28, Deepak Kumar Gupta, Noida wrote:

> In my case after uncompressing the kernel, it just hangs. Even the SCSI disk
> driver is not loaded, so i guess problem is some where else. I am using
> Symbios (SYM53C8XX) driver. 
> 

Deepak,

   As David mentioned, 2.5.75 is rather old.  Please try 2.6.0-test9 and
start with one of the configs David pointed at on the Gelato URL.  If
you're using a VGA console, it's easy to configure the kernel to not get
output where you want it.  If you're trying to use a serial console,
make sure you're appending a 'console=ttyS0,<speed>n8' to your elilo
entry.  Note that it depends how you have your firmware setup as to
whether ttyS0 is the builtin UART port or the 'console' port on the
management port (if you have one).  You can check this in the EFI boot
option maintenance menu.  Choose one, and only one, UART port for the
console output device.  The PNP0501 entry is the builtin UART, the
HWP0002 is the management  port.  Also, the on-board scsi controller for
the zx6000 is the mpt fusion driver, not the sym driver.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

