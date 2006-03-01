Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWCAE2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWCAE2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWCAE2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:28:41 -0500
Received: from smtpout.mac.com ([17.250.248.97]:21208 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751665AbWCAE2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:28:40 -0500
In-Reply-To: <20060228223855.GC5831@elf.ucw.cz>
References: <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com> <20060228223855.GC5831@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF133E7F-3A98-4C01-BC5D-7AA428499C3A@mac.com>
Cc: col-pepper@piments.com, LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 23:28:30 -0500
To: Pavel Machek <pavel@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2006, at 17:38:55, Pavel Machek wrote:
> I have seen flash disk dead in 5 minutes, even without o-sync.  
> Those devices are often crap. (I copied tar file to flash by cat  
> foo.tar > /dev/sda. That was apparently enough to kill that flash.  
> Label "Yahoo" should have warned me).

Sometimes a flash device can have a temporary error condition that is  
solved by rewriting the data.  (I've seen it triggered by buggy USB  
hubs that don't provide the rated power).  It seems that a number of  
flash drives have internal checks, and when those trigger it reports  
a bad sector (even if it isn't permanently bad).  My 1GB flashdrive  
failed in that way, and I was able to fix the error by erasing with  
"dd if=/dev/full of=/dev/usbkey" and reformatting.  After the error  
occurred I started md5summing every file I put on the drive, but I've  
been using it for a month now and not a single checksum has miscomputed.

Cheers,
Kyle Moffett
