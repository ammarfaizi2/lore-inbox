Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUJXVFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUJXVFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUJXVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:05:46 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:1035 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261603AbUJXVFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:05:31 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: XFS strangeness, xfs_db out of memory
Date: Sun, 24 Oct 2004 23:05:25 +0200
User-Agent: KMail/1.7.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200410240857.31893.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.53.0410241349270.23661@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410241349270.23661@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242305.26616.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 13.53, Jan Engelhardt wrote:
> >I was testing a tiny script on top of xfs_fsr to show fragmentation and
> > the resultss of defragmentation.  As a result of fine tuning the output I
> > ran the script repeatedly and suddenly got error from find (unknown error
> > 999 if my memory serves me. It scrolled off the screen).
> >
> >The logs show this.
> >Oct 24 08:06:50 xine kernel: hda: dma_timer_expiry: dma status == 0x21
> >Oct 24 08:07:00 xine kernel: hda: DMA timeout error
> >Oct 24 08:07:00 xine kernel: hda: dma timeout error: status=0xd0 { Busy }
> >Oct 24 08:07:00 xine kernel:
> >Oct 24 08:07:00 xine kernel: hda: DMA disabled
> >Oct 24 08:07:00 xine kernel: ide0: reset: success
>
> Hi,
>
> That looks to me like your HD is going to die sometime in the future...
That's for certain. The question is if it's the near future. It's only a 
couple of months old.

> >How bad is that for XFS?... The error isn't permanent it seems.
>
> Usually nothing. Expect <any fs> to struggle when such IO/DMA errors
> happen.
What I'm thinking about is if XFS ever saw the problem or if the kernel 
retried the operation or what? I'm really curious as to what happened.

> >After that xfs_db -r /dev-with-home -c "frag -v" gives me an out-of-memory
> >error after a while, consistently.
>
> XFS has probably picked up a malicious value due to the disk error, and as
> such allocates that much. Probably more than you got.
Or these errors comes from previously unclean poweroffs (i.e. a hung system).

> >I ran the script repeatedly and suddenly got error from find (unknown
> > error 999 if my
>
> If you reboot, and restart this repeated test, does it always error out at
> the same time and spot (and with the same error 0x21/0x90), e.g. the 100'th
> instance of xfs_db?
>
> Please also try a badblocks -vv /dev/hdXY (or appropriate) repeatedly. If
> it finds something there after a lot of runs (at least as much as you
> needed to find out the fragmentation), there's definitely something wrong
> with the HD, not XFS.

I've tried it a few times, nothing so far. When I think again I have actually 
seen this (or similar error) before. The logs only contains this instance of 
the error, so it must be at least a month since int happended last.

-- robin
