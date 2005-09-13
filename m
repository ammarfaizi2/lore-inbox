Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVIMKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVIMKdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVIMKdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:33:33 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:19132 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932591AbVIMKdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:33:32 -0400
Message-ID: <4326AAF8.2060702@shadowconnect.com>
Date: Tue, 13 Sep 2005 12:33:28 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Couple of I2O sysfs changes
References: <200509122331.59554.dtor_core@ameritech.net>
In-Reply-To: <200509122331.59554.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dmitry Torokhov wrote:
> I was looking at the users of class_interfaces and stumbled across
> I2O subsystem. As far as I understand the purpose of class interfaces
> was to provide different 'views' on the hardware, not just to have
> a callback to finish initialization of sysfs structures. I think it
> woudl be better to remove i2o_device_class_interface and create
> user/parent links right after class device registration.

OK, think i've misunderstood the description of the class interface :-(

> Also, it looks like i2o_device_class itself is not needed - correct
> me if I am wrong, but all i2o devics reside on their own bus so
> i2o_devices class simply mirrors iformation from the bus and can
> also be safely removed.

Nope, there is one bus per controller not per device...

> Please consider applying the 2 pathes below (just compile-tested,
> don't have proper hardware).

I'll try to merge the changes (and some other patches) in the near future 
and provide a changed patch...

Thank you very much.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
