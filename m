Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWCQQfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWCQQfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWCQQfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:35:00 -0500
Received: from [84.204.75.166] ([84.204.75.166]:38879 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751368AbWCQQe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:34:59 -0500
Message-ID: <441AE532.7050007@yandex.ru>
Date: Fri, 17 Mar 2006 19:34:58 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru> <20060316175858.GA7124@kroah.com> <4419A9B8.8060102@yandex.ru> <20060316182018.GA4301@kroah.com> <441A819F.7040305@oktetlabs.ru> <20060317151858.GA31318@kroah.com>
In-Reply-To: <20060317151858.GA31318@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> So, you should still use the driver core for virtual devices (we have
> lots of virtual devices in the driver model today.)
> 
> Why are you not using it?  What kind of device do you have?  Why does it
> not fit into any existing device model (platform, system, etc)?
> 
Actually I tried to use this model first. I hit on problems with and you 
said that I should avoid using the device model.

Unfortunately I cannot so far say what I'm writing. The below is a cite 
from my old mail which illustrates the sort of my device:

"In connection with this, I have a question. There is a whole bunch of
drivers which do not directly relate to hardware devices, but which
still want to expose their parameters via sysfs. For example, this could
be a filesystem, LVM, a compression layer on top of a file system of a
block device, whatever. These are "virtual" devices and they are not
physically connected to any bus. How should they deal with sysfs?"

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
