Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbTHURV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTHURV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:21:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:51139 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262878AbTHURV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:21:26 -0400
Date: Thu, 21 Aug 2003 10:08:22 -0700
From: Greg KH <greg@kroah.com>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to use an USB<->serial adapter?
Message-ID: <20030821170822.GA3584@kroah.com>
References: <3F44BEA2.8010108@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44BEA2.8010108@freemail.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 02:44:18PM +0200, Boszormenyi Zoltan wrote:
> Hi,
> 
> I am experimenting with a Prolific USB<->RS232 adaptor. We have
> in-house developments that need serial communication and there
> are more and more mainboards that provide only one RS232 connector.
> (We would need more in one machine...)
> So we decided to try an usb-serial converter. The one we bought
> was happily recognized by a RedHat 9 system but I couldn't get
> two-way communication over this converter.

Which kernel version are you using?

I didn't run your test programs, but are you sure you got the hardware
flow control settings correct?  How about testing the device with
minicom, as that is a program that is known to work properly with these
devices (along with lots of other ones, but that's a good place to
start.)

> setserial produces an error:
> 
> # setserial /dev/ttyUSB0
> Cannot get serial info: Invalid argument

Yes, setserial does not work with the majority of the usb-serial
drivers, patches gladly accepted to fix this :)

thanks,

greg k-h
