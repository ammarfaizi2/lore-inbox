Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263387AbVFYJlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbVFYJlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVFYJj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:39:29 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:23388 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S263384AbVFYJj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:39:26 -0400
Message-ID: <42BD2649.5090008@tls.msk.ru>
Date: Sat, 25 Jun 2005 13:39:21 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices
 from userspace
References: <20050624051229.GA24621@kroah.com> <Pine.LNX.4.50.0506240855460.24799-100000@monsoon.he.net> <20050625032715.GB3934@kroah.com> <200506242316.10958.dtor_core@ameritech.net>
In-Reply-To: <200506242316.10958.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
[bind/unbind in device or driver dir in sysfs]
> 
> Actually, I think that both should be in device's directory. When unbinding
> a device you normally don't care what driver it is bound to, you just want
> to make sure that there is no driver bound to the device afterwards. I.e it
> is a operation on device. When binding you could argue both ways, but then
> again you usually have a piece of hardware you want to assign specific driver
> for, so I'd say it is operation on device as well.

A small comment.  How about having one file named 'bind', which acts like
either bind or unbind if nothing (empty string) has written to it?

(for fun.. that'd be 'driver' file, which, when read, returns the name
of the driver currently bound to the device.. but too bad, 'driver' is
a symlink already...)

/mjt
