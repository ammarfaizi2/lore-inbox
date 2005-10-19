Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVJSOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVJSOxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVJSOxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:53:04 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:10375 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751019AbVJSOxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:53:03 -0400
Message-ID: <43565DCF.5020404@rtr.ca>
Date: Wed, 19 Oct 2005 10:53:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression
References: <Pine.LNX.4.44L0.0510172048290.30056-100000@netrider.rowland.org> <200510191514.00186.rjw@sisk.pl>
In-Reply-To: <200510191514.00186.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

None of the recent kernels can resume-from-ram reliably for me
if I use CONFIG_USB_SUSPEND (set).   But with that option UNset,
suspend/resume to/from RAM works very well.

BUT.. new in 2.6.14-rc*, is that the ehci_hcd USB hispeed driver
no longer survives resume from ram.  I have to unload/reload the
module to get hispeed USB after resume.

-ml
