Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWDDIMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWDDIMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDDIMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:12:36 -0400
Received: from [84.204.75.166] ([84.204.75.166]:14720 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932088AbWDDIMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:12:35 -0400
Message-ID: <44322A6F.4000402@yandex.ru>
Date: Tue, 04 Apr 2006 12:12:31 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: device model and character devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

at the moment the device model and the character devices subsystem are 
distinct and different things. I mean, if I have a device xdev, I do the 
following:

struct xdev_device {
	struct cdev cdev;
	struct device dev;
	/* xdev-specific stuff */
	...
} xdev;

I use xdev.cdev to register character device:

cdev_add(&xdev.cdev, ...);
...

I use xdev.dev functions to include my device to the device-model:

device_register(&xdev.dev, ...);
...

But why not to merge the character device stuff and the device model? 
Roughly speaking, why not to embed 'struct cdev' to 'struct device'? Why 
do driver writers have to distinguish between these things?

Thanks.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
