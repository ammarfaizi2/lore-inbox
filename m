Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSLOOXF>; Sun, 15 Dec 2002 09:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSLOOXF>; Sun, 15 Dec 2002 09:23:05 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:16721 "EHLO
	ubik.localnet") by vger.kernel.org with ESMTP id <S261582AbSLOOXE>;
	Sun, 15 Dec 2002 09:23:04 -0500
Message-ID: <3DFC921C.1030302@murphy.dk>
Date: Sun, 15 Dec 2002 15:30:52 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: early_serial_setup is broken in the 2.5 series
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see early_serial_setup should be capable of being
used to dynamically setup a serial port at any time in the boot
process - this is certainly the case in the 2.4 kernels.

However if it is used during architecture initialization, for example,
then the serial8250_reg uart driver has not been registered and
initialized even though it is used in the early_serial_setup call.

What was wrong with the 2.4 implimentation where the registered
serial ports were saved until the serial driver was ready to use them?

/Brian

