Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHSKF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHSKF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUHSKF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:05:28 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:16030 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264919AbUHSKFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:05:13 -0400
Message-ID: <41247E0E.8030005@shadowconnect.com>
Date: Thu, 19 Aug 2004 12:16:46 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com> <20040819104829.A7705@infradead.org>
In-Reply-To: <20040819104829.A7705@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
>>>add a controller_add and add controller_remove method, taking a typesafe
>>>i2o_controller * instead of the multiplexer.
>>I had this before, but i want the notification also for I2O devices, 
>>because the driver model won't call probe functions for devices, which 
>>are already occupied by a other driver.
> Then please add more methods.  Multiplexer calls are an extremly bad idea.

Okay, i prefer type safety too, but i also don't like too many functions...

What do you think about that:

enum i2o_notify {
	ADD = 0;
	REMOVE = 1;
}

i2o_notify_controller(enum i2o_notify, struct i2o_controller *);
i2o_notify_device(enum i2o_notify, struct i2o_device *);



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
