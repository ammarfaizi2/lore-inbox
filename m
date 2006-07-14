Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWGNKOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWGNKOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWGNKOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:14:30 -0400
Received: from javad.com ([216.122.176.236]:40464 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1161019AbWGNKO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:14:29 -0400
From: Sergei Organov <osv@javad.com>
To: Greg KH <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <20060630001021.2b49d4bd.akpm@osdl.org>
 <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
	<87d5cdg308.fsf@javad.com>
	<1152529855.27368.114.camel@localhost.localdomain>
	<873bd9fobb.fsf@javad.com>
	<1152552683.27368.185.camel@localhost.localdomain>
	<8764i1h9nd.fsf@javad.com> <1152805246.17919.2.camel@localhost>
	<87veq1fjto.fsf@javad.com> <20060713190806.GA32525@suse.de>
Date: Fri, 14 Jul 2006 14:13:59 +0400
In-Reply-To: <20060713190806.GA32525@suse.de> (Greg KH's message of "Thu, 13
	Jul 2006 12:08:06 -0700")
Message-ID: <87fyh4fq8o.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:
> On Thu, Jul 13, 2006 at 10:20:19PM +0400, Sergei Organov wrote:
[...]
>> Besides, if the throttle() is that important and failure to handle it is
>> a big mistake, why is it optional then? I mean why struct tty_operations
>> with throttle field set to NULL is accepted in the first place? The same
>> question is applicable to the struct usb_serial_driver.
>
> Yes, I didn't realize it was required.

That was my point, -- people don't realize it is dangerous not to handle
throttle, and in fact it was not that dangerous before new tty buffering
has been implemented. I do handle throttle in my driver, but it has been
implemented as a part of work-around for the deficiencies of the old tty
buffering. I seriously doubt I'd realize it's a must to honour throttle
should I start to write the driver today.

-- 
Sergei.
