Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWINHPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWINHPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWINHPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:15:23 -0400
Received: from outmx002.isp.belgacom.be ([195.238.5.52]:1690 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751382AbWINHPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:15:23 -0400
Date: Thu, 14 Sep 2006 09:15:04 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Samuel Tardieu <sam@rfc1149.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-ID: <20060914071504.GA2585@infomag.infomag.iguana.be>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net> <1157817522.6877.46.camel@localhost.localdomain> <2006-09-09-17-38-12+trackit+sam@rfc1149.net> <2006-09-09-18-28-44+trackit+sam@rfc1149.net> <20060909214941.GA5192@martell.zuzino.mipt.ru> <2006-09-10-00-11-56+trackit+sam@rfc1149.net> <20060909222718.GB5192@martell.zuzino.mipt.ru> <20060913191504.GA2386@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913191504.GA2386@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> My opinion: a watchdog device is a special "harware monitoring" device and
> thus we should combine the existing hwmon and watchdog code in one driver
> where possible.
> This will definitely not solve all SuperIO alike problems but it is a first
> step towards having a single device driver for every autonomous piece of
> electronics.
> 
> We can start with the Winbond SuperIO chipsets (Rudolf allready started
> this (see his initial mail about Watchdog device classes)).
> We should also change/convert the /dev/temperature setup in the watchdog
> drivers to a hwmon-alike setup. I will definitely do this for the pcwd 
> drivers. And secondly we should define how we handle "temperature panic's"
> because there we still have differences between the watchdog drivers.

Just an extra thought: the current drivers directory is a mix of bus related
(pci, usb), /dev/* (char, block, ...) related and functionality related 
(bluetooth, cdrom, hwmon, watchdog, ...) items. Since our device drivers are
gradually moving to the new driver structure (with sysfs support) where
everything is bus related we will probably need to think how we best manage
this towards the user that will compile his kernel. (For instance: the 
watchdog usb driver depend on USB but USB is only later selectable if you do
a make config...)
Perhaps we will have in the future a drivers directory that is even oriented
towards the different busses (pci, usb, platform, isa, eisa, sbus, ...)

Greetings,
Wim.

