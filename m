Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJSRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJSRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:03:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3723 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261892AbTJSRDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:03:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: kris <kris.buggenhout@skynet.be>
Subject: Re: problems with Seagate 120 GB drives when mutlwrite = 16
Date: Sun, 19 Oct 2003 19:08:14 +0200
User-Agent: KMail/1.5.4
References: <1066578892.3091.11.camel@borg-cube.lan>
In-Reply-To: <1066578892.3091.11.camel@borg-cube.lan>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310191908.14369.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 of October 2003 17:54, kris wrote:
> Hi,

Hi,

> I have noticed some problems with recent large drives, connected to a
> variety of controllers.
>
> I tested with nforce ide controller, a CMD649 based controller and an
> Intel 870 cghipset. all have same or similar symptoms.
>
> Linux 2.4.22 kernel : (Linux borg-cube 2.4.22-xfs #2 SMP Tue Oct 7
> 20:53:04 CEST 2003 i686 unknown)
>
> Oct  6 15:52:12 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
> 0x21
> Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
> Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
> Oct  6 15:52:22 borg-cube kernel: hdg: status error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Oct  6 15:52:22 borg-cube kernel:
> Oct  6 15:52:22 borg-cube kernel: hdg: drive not ready for command
> Oct  6 15:52:22 borg-cube kernel: hdg: status timeout: status=0xd0 {
> Busy }
> Oct  6 15:52:22 borg-cube kernel:
> Oct  6 15:52:22 borg-cube kernel: hdg: no DRQ after issuing WRITE
> Oct  6 15:52:22 borg-cube kernel: ide3: reset: success
>
> same in 2.4.20 ( kernel from Suse)
>
> 2.6.0-test6 :
>
> Oct  9 09:43:09 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
> 0x21
> Oct  9 09:43:18 borg-cube kernel:
> Oct  9 09:43:19 borg-cube kernel: hdg: DMA timeout error
> Oct  9 09:43:19 borg-cube kernel: hdg: dma timeout error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Oct  9 09:43:19 borg-cube kernel:
> Oct  9 09:43:19 borg-cube kernel: hdg: status timeout: status=0xd0 {
> Busy }
> Oct  9 09:43:19 borg-cube kernel:
> Oct  9 09:43:19 borg-cube kernel: hdg: no DRQ after issuing MULTWRITE
> Oct  9 09:43:20 borg-cube kernel: ide3: reset: success
>
> same in 2.6.0-test8
>
> so behaviour is consistent.
>
> I can avoid this with either turning off dma access or disabling the
> multwrite ( hdparm -m0 /dev/hdg)
>
> is this a known bug, or should I file one ?

Error message is known, but fact that disabling PIO multiwrite cures
it is new, so please fill bugzilla entry.

Thanks!!
--bartlomiej

