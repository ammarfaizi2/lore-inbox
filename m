Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUBAV7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUBAV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:59:43 -0500
Received: from imap.gmx.net ([213.165.64.20]:30346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265513AbUBAV7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:59:40 -0500
X-Authenticated: #222435
Date: Sun, 1 Feb 2004 23:00:10 +0100
From: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-Id: <20040201230010.15874b4c.diemer@gmx.de>
In-Reply-To: <20040201212802.GA16301@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de>
	<20040129230250.GA9988@kroah.com>
	<20040201215721.737ef5a3.diemer@gmx.de>
	<20040201212802.GA16301@kroah.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004 13:28:03 -0800
Greg KH <greg@kroah.com> wrote:

> You mean "submit a urb and be notified when it was completed?"  I
> thought libusb supported that with signals.

Yeah, thats what I meant. In the html doc shipped with version 0.1.7,
it says "all functions in libusb v0.1 are synchronous, meaning the
functions block and wait for the operation to finish or timeout before
returning execution to the calling application. Asynchronous operation
will be supported in v1.0, but not v0.1."...


> What other way can a userspace library do this?  It doesn't take very
> long at all, what is the problem with this?

Well, I would have liked a lib-function like 
find_device(int vend_id,int prod_id);
but thats really not a big deal.

> Remember that sysfs is "1 value per file".  If that works for your
> device, then I suggest you look at the usbled driver, as that is a
> tiny usb driver that only uses sysfs.  Nothing like a 4kb kernel
> driver :)

Thanks for that hint, I'll have a look at it. I only need 1 val per
file, i.e. a "firmware" file, which I learned is best done with the
firmware_class.

>Good luck
Thanks

regards
Jonas

PS: CC me in replies, please.
