Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVGVDKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVGVDKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVGVDKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:10:41 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:28965 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S262024AbVGVDKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:10:31 -0400
Date: Thu, 21 Jul 2005 23:06:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Why build empty object files in drivers/media?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>
Message-ID: <200507212309_MC3-1-A534-95EE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have this in my .config file for 2.6.13-rc3:


#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set


And yet these completely empty files are being built:


$ find drivers/media -name built-in.o | xargs ls -go
-rw-rw-r--  1 305 Jul 16 00:20 drivers/media/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/common/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/b2c2/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/bt8xx/built-in.o
-rw-rw-r--  1 305 Jul 16 00:20 drivers/media/dvb/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/cinergyT2/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/dvb-core/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/dvb-usb/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/frontends/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/pluto2/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/ttpci/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/ttusb-budget/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/dvb/ttusb-dec/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/radio/built-in.o
-rw-rw-r--  1   8 Jul 16 00:20 drivers/media/video/built-in.o

$ size drivers/media/built-in.o
   text    data     bss     dec     hex filename
      0       0       0       0       0 drivers/media/built-in.o


__
Chuck
