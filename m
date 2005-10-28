Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVJ1GzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVJ1GzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVJ1GzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:55:07 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:35964 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965116AbVJ1GzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:55:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] Driver Core: document struct class_device properly
Date: Fri, 28 Oct 2005 01:54:59 -0500
User-Agent: KMail/1.8.3
References: <11304810242041@kroah.com>
In-Reply-To: <11304810242041@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510280154.59943.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 01:30, Greg KH wrote:
> [PATCH] Driver Core: document struct class_device properly
...

> + * @release: pointer to a release function for this struct class_device.  If
> + * set, this will be called instead of the class specific release function.
> + * Only use this if you want to override the default release function, like
> + * when you are nesting class_device structures.
> + * @hotplug: pointer to a hotplug function for this struct class_device.  If
> + * set, this will be called instead of the class specific hotplug function.
> + * Only use this if you want to override the default hotplug function, like
> + * when you are nesting class_device structures.

Greg, 

Is this solution for nesting class devices considered permanent or is it
a stop-gap measure? I hope it is latter as these 2 new methods allow one
class device walk all over class's intended interface and semantics and
you can no longer rely that objects of the same class have similar
characteristics/attributes and similar behavior. You already had to
abandon using class's default attributes when dealing with nested devices,
I think it is wrong long-term solution.

What about Kay's proposal about moving (as far as userspace concerned)
everything into /sys/devices?

-- 
Dmitry
