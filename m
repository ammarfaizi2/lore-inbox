Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTFBQHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTFBQHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:07:52 -0400
Received: from node-c-7b22.a2000.nl ([62.194.123.34]:6784 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id S262567AbTFBQHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:07:50 -0400
Message-ID: <3EDB797B.1050206@xs4all.nl>
Date: Mon, 02 Jun 2003 18:21:15 +0200
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Paul Rolland" <rol@as2917.net>, linux-kernel@vger.kernel.org
Subject: Re: Serial port numbering (ttyS..) wrong for 2.5.61+
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >>Hello,
 >
 >> Since I tried the 2.5 kernel versions somewhere in the 2.5.6x range, I
 >> see rather odd port naming for the extra 4 serial ports on a PCI-card.
 >Which driver are you using ?

See attached CONFIG_SERIAL* from my config, this is the 'standard'
serial port driver.

 >
 >> The first two are numered as ttyS14, ttyS15 while the last two are
 >> ttyS2 and ttyS3 !
 >> I tried to find where these numbers are coming from but
 >> couldn't really
 >> find an obvious place in the various drivers/char/* or
 >> drivers/serial/*
 >> files.
 >
 >Numbering seems to be coming out of
 >drivers/serial/core.c : uart_find_match_or_unused
 >which is responsible for finding an unused state for the port.
 >
 >However, the code there seems to be clean and I guess we should look
 >where the state are initialized.
 >
 >Paul


==============================================================

# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=y
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y



