Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTHUPIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTHUPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:08:24 -0400
Received: from ext-ch1gw-2.online-age.net ([216.34.191.36]:20414 "EHLO
	ext-ch1gw-2.online-age.net") by vger.kernel.org with ESMTP
	id S262763AbTHUPIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:08:23 -0400
Message-ID: <A9D3E503844A904CB9E42AD008C1C7FDBA9C36@vacho3misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Pankaj Garg'" <PGarg@MEGISTO.com>, linux-kernel@vger.kernel.org
Subject: RE: Messaging between kernel modules and User Apps
Date: Thu, 21 Aug 2003 11:05:27 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am writing a kernel module. The module will need to send asynchronous
> messages to a User Application. Is there a good and efficient way of
> doing this?

Let user space read the data from a device file.
Use poll/select to handle the asynchronous notification.

The other option is to have the driver send a signal to user space.
I've done that before, but at best it's a hack and not neatly supported
by the Linux driver model.


