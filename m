Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDTXee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDTXee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVDTXee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:34:34 -0400
Received: from fmr19.intel.com ([134.134.136.18]:43168 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261840AbVDTXeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:34:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc2-mm3 pciehp regression
Date: Wed, 20 Apr 2005 16:34:03 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E04FFF546@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc2-mm3 pciehp regression
Thread-Index: AcVF4ipK4Qs9+RTESOqnkeAxkSVIZQAHOKng
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Tom Duffy" <tduffy@sun.com>
Cc: <linux-kernel@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>
X-OriginalArrivalTime: 20 Apr 2005 23:34:05.0240 (UTC) FILETIME=[70DD7380:01C54601]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 20, 2005 12:50 PM, Tom Duffy wrote:
> > The errors I encountered were:
> > Reading all physical volumes.  This may take a while...
> > Umount /sys failed: 16
> > mount: error 6 mounting ext3
> > mount: error 2 mounting none
> > Switching to new root
> > Switchroot: mount failed 22
> > umount /initrd/dev failed: 2
> >
> > I also encountered issue you & others discussed in the thread on
> > "Re: Heads up on 2.6.12-rc1 and later" if I used SCSI drive.
> > 
> > Can you send me the config file you used successfully on your 
> > system?
>
> You will need to boot the system UP (not SMP).  There is a problem
> with modules loading too fast that causes the initrd to fail.

This doesn't help on my system.  I tried both ways: using boot option 
with nosmp, and rebuilding kernel with SMP off in config file.  

Using nosmp, I got:
IOAPIC [0]: Invalid reference to IRQ 0
.
.
audit(....) initialized
ide 1 : ....
id1 1 : ports already in use, skipping

and system halted

Rebuilding kernel with SMP off in config file, I got:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)

Thanks,
Dely

