Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVIMEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVIMEfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 00:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIMEfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 00:35:04 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:23486 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751049AbVIMEfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 00:35:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: markus.lidel@shadowconnect.com
Subject: [PATCH 0/2] Couple of I2O sysfs changes
Date: Mon, 12 Sep 2005 23:31:59 -0500
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509122331.59554.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

I was looking at the users of class_interfaces and stumbled across
I2O subsystem. As far as I understand the purpose of class interfaces
was to provide different 'views' on the hardware, not just to have
a callback to finish initialization of sysfs structures. I think it
woudl be better to remove i2o_device_class_interface and create
user/parent links right after class device registration.

Also, it looks like i2o_device_class itself is not needed - correct
me if I am wrong, but all i2o devics reside on their own bus so
i2o_devices class simply mirrors iformation from the bus and can
also be safely removed.

Please consider applying the 2 pathes below (just compile-tested,
don't have proper hardware).

-- 
Dmitry
