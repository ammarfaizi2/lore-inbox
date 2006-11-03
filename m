Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753288AbWKCP4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbWKCP4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbWKCP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:56:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19423 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753288AbWKCP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:56:45 -0500
Subject: Re: irqpoll kernel option hurts performance?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xp newbie <xp_newbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103151026.28031.qmail@web38409.mail.mud.yahoo.com>
References: <20061103151026.28031.qmail@web38409.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Nov 2006 16:00:58 +0000
Message-Id: <1162569659.12810.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-11-03 am 07:10 -0800, ysgrifennodd xp newbie:
> Thank you, Alan. Indeed, it is a desktop machine so I
> guess I should not be too concerned. I should note
> hoever that while downloading an ISO image from the
> Internet and doing nothing else (not even moving the
> mouse), the System Monitor showed CPU usage of 15%.
> The same machine booting to Windows 2000, shows in
> such circumstances 0% CPU use (something lesser than
> 1% to be more exact).

The two systems don't measure performance the same way. That makes
comparisons using their own monitoring tools a bit dubious and can make
either OS look better in cases where it isn't

> But that board, again, was running Windows 2000
> without any performance sacrifices... How does Windows
> achieve that trick?

I wish I knew. One possibility - especially as this appears to be the
USB 2.0 is that it provides different rules for different OS's (thats
intended to be a feature so it can hide EHCI from old windows etc)

You might want to see if booting with the kernel option	"acpi_noirq" has
any effect for the better, you can also spoof different versions of
windows for ACPI using

	acpi_os_name="Microsoft Windows"

(Not sure how you spoof XP etc offhand but it should be documented
somewhere)

Various things are going on to improve the poor state of PC BIOSes
including a firmware test kit from Intel.

> I know that there is an issue with Promise
> controllers, as Promise releases only binaries of its
> drivers for Linux, not the source code. :(

Actually promise are generally providing both docs and their own binary
driver. 


