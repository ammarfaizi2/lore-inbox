Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUFIHZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUFIHZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 03:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265685AbUFIHZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 03:25:57 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:361 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265676AbUFIHZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 03:25:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Couple of sysfs patches
Date: Wed, 9 Jun 2004 02:21:24 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406090221.24739.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to add sysfs support to the serio subsystem and I would like you
to consider the following changes:
 
- when registering platform device, if device id is set to -1, do not add it
  as a suffix to device's name. It can be used when there is only one device.
  The reason for change - i find that i80420 looks ugly, just i8042 is much
  better ;)

- create platform_device_simple_releasse function that would just free memory
  occupied by platform device. Having such release routine in core allows
  drivers implementing simple platform devices not wait in module unload code
  till last reference to the device is dropped.

And of course whitespace changes ;) in the very first patch.

Please consider applying.

-- 
Dmitry
