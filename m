Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVCUWJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVCUWJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCUWJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:09:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:54974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbVCUWJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:09:39 -0500
Date: Mon, 21 Mar 2005 14:09:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: iostat values broken ?
Message-Id: <20050321140942.344fff89.akpm@osdl.org>
In-Reply-To: <d053g8$6et$1@news.cistron.nl>
References: <d053g8$6et$1@news.cistron.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>
> I just upgrades one of our newsservers from 2.6.9 to 2.6.11. I
> use "iostat -k -x 2" to see live how busy the disks are. But
> I don't believe that Linux optimizes things so much that a disk
> can be 1849.55% busy :)
> 
> (you'll have to stretch out your xterm to be able to read this):
> 
> Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
> hda          0.00  50.00  0.00 18.18    0.00  545.45     0.00   272.73    30.00     2.35  129.00  86.25 156.82
> hdc          0.00  45.45 77.27 31.82 3927.27  618.18  1963.64   309.09    41.67     6.27   57.42  38.42 419.09
> hdd          4.55   0.00 63.64  0.00   68.18    0.00    34.09     0.00     1.07     1.11   17.43  17.43 110.91
> hde        477.27   0.00 45.45  0.00  522.73    0.00   261.36     0.00    11.50     0.40    8.90   8.90  40.45
> hdg         18.18 70154.55 22.73 172.73   40.91 70727.27    20.45 35363.64   362.07  1010.36 1127.72  94.63 1849.55
> 
> With 2.6.9, %util never came above 100% (and that was indeed "fully loaded".
> I have systems with a comparable load running 2.6.10 and 2.6.11-rc3-bk4
> that also don't show this behaviour (but those are SCSI, not IDE).
> 
> I use CFQ, but changing that to deadline doesn't make a difference.
> 

Mike, did you ever get to the bottom of this?  Still happening in 2.6.12-rc1?
