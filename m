Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267249AbUHDCqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUHDCqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUHDCqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:46:21 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:36311 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267249AbUHDCqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:46:19 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408031928.08475.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091586381.3189.14.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 12:26:21 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 12:28, David Brownell wrote:
> > Right now, we are trying to at least get the full system suspend
> > working, we can work on fixing partial-tree suspend (which is what you
> > want there) later.
> 
> The "partial tree suspend" works only for the degenerate
> tree:  every device in the system!  Wakeup events also need
> some more attention.
> 
> There's now some partial-tree code in CONFIG_USB_SUSPEND (for
> developers only), but jumping from USB into the next level driver
> (SCSI, video, etc) raises questions.

I've also done partial-tree support for suspend2 by making a new list
(along side the active, off and off_irq lists) and simply moving devices
I want to keep on (plus their parents) to this list prior to calling
device_suspend. Works well for keeping alive the ide devices being used
write the image.

Regards,

Nigel

