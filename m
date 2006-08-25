Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWHYLzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWHYLzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHYLzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:55:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:47285 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751139AbWHYLze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:55:34 -0400
Date: Fri, 25 Aug 2006 13:55:32 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060825115532.GF221@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,
I have also a T60 and for me it worked after 2 days of compiling kernels
and trying combinations.  For me suspend to ram only works with the
following: Kernel 2.6.17.7 and ipw3945-1.0.5, ATI binary driver and
*loaded* ATI Kernel Module.  With newer kernel versions or newer ipw3945
it did not work any longer (or it worked once and as soon as I tried
consecutive suspend to ram it stopped working). Oh and if you have high
latency with your e1000 network card (500ms - 1 second and laggy ssh to
a machine on the same lan segement) disable the parallel port in the
bios and irq load balancing in the kernel config. Oh and when I have
sshfs mounted it does not to suspend to ram so get sure that you umount
all sshfs mounted filesystems, if you use it at all.

With the above combination everything I need works:

        * sound
        * ati binary only driver
        * suspend to ram
        * e1000
        * wifi

When I tried newer / older kernel versions at least one of the above broke. I
sometimes still have no sound or e1000, but a reboot fixes the problem for me.
For e1000 I also "#if 0"ed the bios checksum in the driver so that it loads
often when no ethernet cable is plugged in.

Also see the notes on: http://vizzzion.org/?id=t60

Let us know, if you proceed.

        Thomas
