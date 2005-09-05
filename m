Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVIESUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVIESUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVIESUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:20:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932353AbVIESUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:20:13 -0400
Subject: Re: EXT3-fs error (device hda8): ext3_free_blocks: Freeing blocks
	not in datazone
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Riccardo Castellani <r.castellani@usl6.toscana.it>
Cc: Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <007b01c5b236$5b6019d0$1f01a8c0@Ric>
References: <007b01c5b236$5b6019d0$1f01a8c0@Ric>
Content-Type: text/plain
Message-Id: <1125944400.1910.19.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 05 Sep 2005 19:20:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-09-05 at 17:24, Riccardo Castellani wrote:
> I'm using FC3 with Kernel 2.6.12-1.1376.
> After few hours file system on /dev/hda8 EXT3 partition has a problem so it 
> remounted in only read mode.

> Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8): ext3_free_blocks: 
> Freeing blocks not in datazone - block = 134217728, count = 1

That block number is 0x8000000 in hex.  It's a single-bit flip error;
that strongly sounds like hardware, and I'd run memtest86 on that box
next.

> Sep  5 17:34:40 mrtg kernel: Aborting journal on device hda8.
> Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in 
> ext3_reserve_inode_write: Journal has aborted
...

> I tried several times to run fsck on this partition and I also tried to 
> remount fs in a new partition, but it happened nothing !

What do you mean?  fsck found nothing wrong?  remount failed?  You _did_
unmount before fscking, did you?

--Stephen
> 

