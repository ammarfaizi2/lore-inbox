Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVBJPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVBJPDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVBJPDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:03:19 -0500
Received: from mail.baslerweb.com ([145.253.187.130]:55315 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S262135AbVBJPDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:03:06 -0500
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: mochel@osdl.org
Subject: platform_get_resource()
Date: Thu, 10 Feb 2005 16:02:29 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200502101602.29771.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

I am writing a driver for a platform device, and I want
the platform to communicate to the driver the resources
allocted for the device. My platform has resources that
are not of the standard kind IORESOURCE_[IO|MEM|IRQ|DMA],
and while I can pass them into a call to
platform_device_register(), I cannot retrieve them in
the driver, because platform_get_resource_byname()
explicitly looks only for the standard resource types.

Is this intentional? To me it seems to make a lot more
sense to return any resource with a matching name regardless
of its type.

thanks,
Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

