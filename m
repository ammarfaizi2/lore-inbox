Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbVLOJ5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbVLOJ5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbVLOJ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:57:33 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:55996 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1422673AbVLOJ5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:57:32 -0500
Date: Thu, 15 Dec 2005 12:58:00 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net, david-b@pacbell.net,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git 0/3] SPI core refresh
Message-Id: <20051215125800.4fa95de6.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

this message fill be followed by the following three ones:
1) updated SPI core from Dmitry Pervushin/Vitaly Wool
2) Atmel MTD dataflash driver port for this core
3) SPI controller driver for Philips SPI controller

This SPI core features:
* multiple SPI controller support
* multiple devices on the same bus support
* DMA support
* DMA-unsafety check
* synchronous and asynchronous transfers
* library for asynchronous transfers on the bus using kernel threads
* character device interface
* custom lightweight SPI message allocation mechanism
* ability to call transfer function from the interrupt context
* no more explicit redundant memory allocations/copys.

The main differences between the previous version and this one:
* handling DMA-unsafe buffer is now completely up to the bus driver
* spi-dev compilation error fixed
* redundant non-NULL check in bus_suspend/bus_resume removed
* mutexes changed to spinlocks in queueing function for spi-thread to make it callable from the
  interrupt context.

I'd also like to encourage those who interested to use CVS on SourceForge to get the latest updates of the SPI core. The CVS root is ':pserver:anonymous@cvs.sourceforge.net:/cvsroot/spi-devel', the module to checkout is spi-core. Hope that helps.

Vitaly
