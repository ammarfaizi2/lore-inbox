Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTEIUna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTEIUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:43:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263438AbTEIUn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:43:27 -0400
Subject: Re: ext3/lilo/2.5.6[89] (was: [KEXEC][2.5.69] kexec for 2.5.69
	available)
From: Andy Pfiffer <andyp@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain
Organization: 
Message-Id: <1052513725.15923.45.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 13:55:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 13:04, Christophe Saout wrote:
> Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:
> 
> > [...]
> >  I had an unrelated
> > delay in posting this due to some strange behavior of late with LILO and
> > my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> > but a subsequent reboot would not include my new kernel)
> 
> So I'm not the only one having this problem... I think I first saw this
> with 2.5.68 but I'm not sure.

Well, that makes two of us for sure.

> 
> My boot partition is a small ext3 partition on a lvm2 volume accessed
> over device-mapper (I've written a lilo patch for that, but the patch is
> working and) but I don't think that has something to do with the
> problem.
> 
> When syncing, unmounting and waiting some time after running lilo, the
> changes sometimes seem correctly written to disk, I don't know when
> exactly.

My /boot is an ext3 partition on an IDE disk.  My symptoms and your
symptoms match -- wait awhile, and it works okay.  If you don't wait
"long enough" the changes made in /etc/lilo.conf are not reflected in
the after running /sbin/lilo and rebooting normally.

I have been unable to reproduce this on a uniproc system with SCSI
disks.

2.5.67 seems to work in this regard as expected.

> Could it be that the location of /boot/map is not written to the
> partition sector of /dev/hda? Or not flushed correctly or something?
> 
> After reboot the old kernel came up again (though it was moved to
> vmlinuz.old).

I don't know -- I haven't isolated it yet.

Anyone else?



