Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUBNQZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBNQZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:25:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:37837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262153AbUBNQZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:25:54 -0500
Date: Sat, 14 Feb 2004 17:25:52 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: Timothy Miller <miller@techsource.com>
Cc: aradford@3WARE.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <402D6354.3010801@techsource.com>
Subject: Re: File system performance, hardware performance, ext3, 3ware RA ID1, etc.
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <30156.1076775952@www12.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

Do you get the same numbers (but slightly higher, as this is will measure
from a smaller portion of outer zones) with:

# hdparm -t /dev/sda

?

> Adam Radford wrote:
> > Perhaps you are issuing non purely sequential IO.  The card firmware
> does
> > some 
> > reodering, but at some point it will cause performance degradation.  Can
> you
> > try 
> > kernel 2.6 w/xfs? 
> 
> Not any time soon, but as I mentioned earlier, I measured 13.9 megs/sec 
> when I ran this command:
> 
>      time dd if=/dev/zero of=/dev/sda2 bs=1024k count=1024
> 
> No file system was involved; I was simply writing zeros to the block 
> device (swap partition with swap off).  It took 73.522 seconds to do the 
> above operation.  Also, I was running in single-user mode while doing 
> the test.
> 
> > 
> > Also, in my experience, the 'raw io' interface doesn't issue any
> > asynchronous IO.  The
> > card _definately_ needs asynchronous IO posted to it or you will not get
> > good results
> > because you won't get all the drives busy.
> 
> With RAID1, both drives will be written with the same data.  There is no 
> need to be asynchronous, since it's all completely linear and sequential 
> with large data blocks.

-- 
Daniel J Blueman

GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

