Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWBDNdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWBDNdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBDNdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:33:39 -0500
Received: from [84.204.75.166] ([84.204.75.166]:55247 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932475AbWBDNdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:33:39 -0500
Message-ID: <43E4AD2F.1020703@yandex.ru>
Date: Sat, 04 Feb 2006 16:33:35 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/sysfs] strange refcounting
References: <1139040821.13125.4.camel@sauron.oktetlabs.ru> <43E4985D.3070708@yandex.ru>
In-Reply-To: <43E4985D.3070708@yandex.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityutskiy wrote:
> I actually forgot to formulate my question: why module's refcount is not 
> increased when somebody opens a sysfs file which belongs to this module? 
> How to withstan to an unexpected module unload?
> 
> Thanks.
I see this code drivers/base/core.c, device_add().

if (dev->driver)
	dev->uevent_attr.attr.owner = dev->driver->owner;

I assume it is expected that I must have a driver structure. But I 
don't. Why do I have to?

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
