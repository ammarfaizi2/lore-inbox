Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265568AbUBBHux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 02:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbUBBHux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 02:50:53 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:38820 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S265568AbUBBHuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 02:50:52 -0500
From: Duncan Sands <baldrick@free.fr>
To: Jonas Diemer <diemer@gmx.de>, unlisted-recipients:;;;""@paldrick.free.fr;,
       ""@pop.free.fr (no To-header on input)
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	unlisted-recipients:;""@paldrick.free.fr
					     ^-missing end of address
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	unlisted-recipients:;""@paldrick.free.fr
					     ^-missing end of address
Subject: Re: Which interface: sysfs, proc, devfs?
Date: Mon, 2 Feb 2004 08:50:48 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040129222813.3b22b2c8.diemer@gmx.de> <20040202032514.GB20534@kroah.com> <20040202075944.522464db.diemer@gmx.de>
In-Reply-To: <20040202075944.522464db.diemer@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402020850.48993.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH <greg@kroah.com> wrote:
> > Yet you want to do asynchronous support with sysfs?  How would that
> > work?
> > What kind of device are you writing a driver for?
>
> It is not firmware uploading only. Once the firmware is uploaded, I will
> communicate with that device. It is a ezusb microcontroller controlling
> several relais, adc and dac.

usbfs certainly supports asynchronous communication (sending an urb
and picking up the result at some convenient later time).  I don't know if
libusb supports it, but in any case it is easy to use usbfs directly.

Duncan.
