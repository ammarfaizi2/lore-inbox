Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbULMAPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbULMAPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbULMAPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:15:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:4839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262178AbULMAPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:15:32 -0500
Message-ID: <41BCDE26.9030309@osdl.org>
Date: Sun, 12 Dec 2004 16:11:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: dummy help on io
References: <200412121854.48898.gene.heskett@verizon.net>
In-Reply-To: <200412121854.48898.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> I've ordered the device drivers book from O-Reilly but it will be
> a few days getting here.

Get it online:
http://lwn.net/Kernel/LDD2/

> I'm trying to mod the GPL'd archive PIO.tar.gz, so it will build a
> driver for a pci card with 3 each 82C55's on it, and I *think* I'd
> have it working with the first of the 3 chips if I could figure
> out what to do about using the call "iopl(3);" on installing
> the driver, and conversely an "iopl(0);" at rmmod time.

Where is that coming from?  I don't see it in the tarball
or the web site (if I'm looking at the right place).
   http://ieee.uow.edu.au/~daniel/software/robotd/

> I'm told this is required to gain access perms to addresses above
> 0x3FF.  The call "ioperm" is used below that I've been told.

iopl() and ioperm() are userspace calls that call (g)libc.
The kernel doesn't call them.

> Unforch, an "insmod PIO io=0xf100" (where the card is addressed
> at currently) is spitting out an "unresolved symbol" error for the
> iopl call.
> 
> Being a rank beginner at "pc" hardware, can someone give me a
> checklist of things I've probably left out please?

Can you put the iopl() call into your app instead?
or into a shell script that forks the app (since the iopl
man page says:  Permissions are inherited by fork and exec.)

> Kernel is 2.4.25-adeos.  With the module "rtai" inserted when emc
> is running for realtime control purposes.
> 
> The card is pure hardware, no bios, only address decoding that
> can set the base address anyplace in the first 64k of address
> space in a step of 4 sequence from 0xnn00-0xnn0C for the 4
> ports of chip 1, 0xnn10-1C for chip 2, etc, where the nn is the
> dipswitch setting.


-- 
~Randy
