Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWGRORz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWGRORz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWGRORz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:17:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10803 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932237AbWGRORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:17:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iufLwRWQCqFZ+wxCN3MBG0S800Wy9tX8kINsFwi9c8qKMkzaHqGnVxJMR2YoBNhbjSGbJkJscwMjDI+6JETsC1JrfzZqX7YxvuNiVWTa5M6A0+eUc9qURSx54md5ELMhpLHSZsKRdnnFA6gylinXjsf5jkHJ6hgmJKlbX22ZXp4=
Message-ID: <f8e53fb0607180717je763dd7v5cd58d5d5c08a2f0@mail.gmail.com>
Date: Tue, 18 Jul 2006 16:17:53 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SPI driver development questions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to develop an SPI device driver to make a PowerPC (mcp5200)
custom board "talk" to an FPGA in order to program it at power on.

I'm using 2.6.16 kernel with support for the spi subsystem enabled. I
also had a look at some new spi-related files coming from 2.6.17

What I'd like to do is to be able to program my FPGA from user space
(namely init scripts), possibly using a standard char device
interface. The binary stream to program the FPGA is stored on the
linux filesystem, so this sounds as the most confortable way to go.

Let me say I have to use the dedicated SPI controller on the 5200, not
the generic PSC module.

I read docs in Documentation/spi and Documentation/driver-model, but
still many questions fly around...

How should I proceed?
Do I have to write a SPI Master Controller Driver for the 5200 first
and than a specific device driver for my FPGA? If so should the master
driver be similar to linux/drivers/spi/spi_mpc83xx.c, taking into
account low level differences in managing the interface?
What exactly will this master driver "export" to the specific device
driver for my FPGA?
I cannot figure out, after registering the master driver how to "bind"
the device driver to the master.

TIA
Regards,
Andrea G.
