Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTFDOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTFDOWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:22:25 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:36829 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S263311AbTFDOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:22:24 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
Date: Wed, 4 Jun 2003 22:35:41 +0800
User-Agent: KMail/1.5.2
Cc: hugang <hugang@soulinfo.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030603211156.726366e7.hugang@soulinfo.com> <200306042210.12468.mflt1@micrologica.com.hk> <1054736960.20838.44.camel@gaston>
In-Reply-To: <1054736960.20838.44.camel@gaston>
X-OS: GNU/Linux+KDE
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306042235.41326.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 22:29, Benjamin Herrenschmidt wrote:
> > hda: start_power_step(susp: 1, step: 0)
> > hda: start_power_step(susp: 1, step: 1)
> > hda: start_power_step(susp: 1, step: 2)
> > hda: complete_power_step(susp: 1, step: 2, stat: 50, err: 0)
> > hda: completing PM request, suspend: 1
> > Suspending devices
> > /critical section: Counting pages to copy[nosave c03f7000] (pages needed:
> > 2273+512=2785 free: 14110) Alloc pagedir
> > ............
> > [nosave c03f7000]critical section/: done (2273 pages copied)
> > hda: Wakeup request inited, waiting for !BSY...
> > hda: start_power_step(susp: 0, step: 0)
> > hda: start_power_step(susp: 0, step: 101)
> > hda: completing PM request, suspend: 0
> > Devices Resumed
> > Devices Resumed
>
> Hrm... the joy if swsusp putting your disk to sleep just to wake it up
> right away... I need to check if I can differenciate suspend-to-disk
> from suspend-to-ram here to just not put the drive in STANDBY mode
> on suspend-to-disk (just freeze the queues)

It did this also in 2.4 until Nigel Cunningham fixed it.

>
> > Writing data to swap (2273 pages): .<3>bad: scheduling while atomic!
>
> Here's the real one. However, it doesn't look related to my sleep code,
> though I cannot guarantee this for sure right now, it _seems_ it's
> a swsusp bug you are hitting.

Well, awaiting the next patch...

Regards
Michael

-- 
Powered by linux-2.5.70-mm3
My current linux related activities in rough order of priority:
- Testing of 2.4/2.5 kernel interactivity
- Testing of Swsusp for 2.4
- Testing of Opera 7.11 emphasizing interactivity
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *
Joke of the day: http://lwn.net/Articles/34848/

