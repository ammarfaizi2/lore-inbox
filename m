Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTKCWfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKCWfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:35:31 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:15831 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261996AbTKCWfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:35:21 -0500
X-Sender-Authentication: net64
Date: Mon, 3 Nov 2003 23:35:18 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux@3ware.com
Subject: Re: [3ware.com #1741] FW: Bug during media scan, k ernel
 2.4.23-pre9
Message-Id: <20031103233518.3ab90092.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003 14:16:15 -0800
"Tom Tran via RT" <support-comment@3ware.com> wrote:

> 
> > -----Original Message-----
> > From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
> > Sent: Monday, November 03, 2003 9:47 AM
> > To: Linux
> > Cc: 
> > Subject: Bug during media scan, kernel 2.4.23-pre9
> > 
> > 
> > Hello,
> > 
> > I just encountered a real bad problem with using media scan on 3ware
> > controllers. I have 3 hds connected and configured a RAID5. I use 
> media scan
> > regularly (daily basis). Since two days I see this problem:
> > 
> > Nov  3 18:12:11 box 3w-xxxx[2039]: INFORMATION: Verify started on 
> unit 0 on
> > controller ID:2. (0x29)
> > Nov  3 18:19:41 box kernel: 3w-xxxx: scsi2: Unit #0: Command 
> (f6e5d800)
> > timed
> > out, resetting card.
> > 
> > After that the box has problems, the controller obviously hangs.
> > This in itself can be considered a bug, but what is really annoying 
> is that
> > one
> > has no chance finding out _which_ port caused the problem.
> > So at this point you can play roulette and replace one of the hds 
> hoping
> > that
> > it was indeed the bad one.
> > 
> > It would be really a lot better to degrade the unit in this case and 
> give a
> > hint which port has problems (command timed out on port ...).
> > This would:
> > a) not hang the box
> > b) give you a chance to replace the hd, as you would expect in RAID5
> > 
> > The current situation is absolutely _no good_.
> > 
> > Regards,
> > Stephan
> 
> 
> What motherboard do you have? Does your motherboard
> bios has an option called "APIC" ? Disable APIC MODE
> if it is enabled. 

Sorry to say that: this setup works since months. It has already showed
correct RAID5 "dropouts" (hd failures, replacements etc). My problem is not
that it does not work or does hang. Sure this is not nice, but the absolute bug
is really _only_ that there is no information about the _cause_ (port) of the
failure. This has nothing to do with apic or not, it is a simple lack of
output information.
 
> If the problems persist, please send us 3dm details,
> 3dm alarms page, and 3dm error log (download from 
> 3dm ALARMS).

The problem will persist, because apic doesn't help the driver to show
output. There is no other useful information in the 3dm logs. In fact the
problem does not even show up there. Last reports are visible in syslog output
as stated in the report.

Regards,
Stephan

PS 3ware: if you send mails for support with questions, please set a
reply-address that is deliverable...

