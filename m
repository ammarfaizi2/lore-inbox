Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbRFNJ0U>; Thu, 14 Jun 2001 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbRFNJ0K>; Thu, 14 Jun 2001 05:26:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:50444 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262242AbRFNJZ6>; Thu, 14 Jun 2001 05:25:58 -0400
Message-ID: <3B2882C0.EDA802E3@idb.hist.no>
Date: Thu, 14 Jun 2001 11:24:16 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: lar@cs.york.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLGEMBDCAA.laramie.leavitt@btinternet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laramie Leavitt wrote:

> Would it be possible to maintain a dirty-rate count
> for the dirty buffers?
> 
> For example, we it is possible to figure an approximate
> disk subsystem speed from most of the given information.

Disk speed is difficult.  I may enable and disable swap on any number of
very different disks and files.  And making it per-device won't help
that
much.  The device may have other partitions with varying access
patterns.
and sometimes differnet devices interfer with each other, such
as two IDE drives on the same cable.  Or several scsi drives
using up scsi (or pci!) bandwith for file access.

You may be able to get some useful approximations, but you
will probably not be able to get good numbers in all cases.

Helge Hafting
