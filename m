Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUBXRZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUBXRVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:21:51 -0500
Received: from web13702.mail.yahoo.com ([216.136.175.135]:29459 "HELO
	web13702.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262318AbUBXRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:20:55 -0500
Message-ID: <20040224172053.58512.qmail@web13702.mail.yahoo.com>
Date: Tue, 24 Feb 2004 09:20:53 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: libata/iswraid DMA Timeout
To: jabbera@student.umass.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1077580276.403a91f4094fe@mail-www4.oit.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- jabbera@student.umass.edu wrote:

> Sorry never posted to this list so bear with me. 
> I am currently using kernel version 2.4.25 i386 with libata and
> iswraid. 
> Note: iswraid is for 2.4.22, but it applied to 2.4.25 without issue. 

Please try the new iswraid that was posted to this list on
Friday, Feb. 20th. It is completely redone and has a lot more
features than what you were using, including /proc fs support,
ICH6R support, updating RAID metadata on errors, ability to
work with many volumes and various configurations of them,
etc., etc. Yes, it's very new and new bugs could have been
introduced but I think you'll be better off with the latest
anyway.
 
> I was using a php script to move a bunch of my files around the file
> system 
> when my system locks up and I see: 
> ata1: DMA timeout, stat 0x21 
> ATA: abnormal status 0x59 on port 0xC407 

I had a bad SATA cable once and was seeing the same thing.
I reported it to libata1 author via personal email.
I don't think iswraid has anything to do with it as this
is a lower level driver issue. Iswraid, both old and new,
are fairly high level drivers that don't deal directly with
the SATA controllers or their interrupts. In fact, iswraid
would work with any SCSI disks that have the right metadata
format on them.

> I try to do an emegency sync but I fails, and I am forced to reboot.

In my experience the system was still usable, except the userland
application was hanging. Adding another SATA transaction (to any
disk, I believe), was what made it hang completely. So I think
we've seen the same problem.

I certainly don't understand enough of libata1 to fix this,
but you could perhaps start by changing your SATA cables or
at least swapping them around to see whether the timeout follows
the cable, perhaps, as it was in my case.

Good luck, and please report back any iswraid bugs/wishes/questions.

  Martins Krikis
  Storage Components Division (SCD)
  Intel Massachusetts


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
