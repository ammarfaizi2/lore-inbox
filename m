Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRCBTlJ>; Fri, 2 Mar 2001 14:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCBTkx>; Fri, 2 Mar 2001 14:40:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47319 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129460AbRCBTki>;
	Fri, 2 Mar 2001 14:40:38 -0500
Date: Fri, 2 Mar 2001 19:38:56 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Stephen Tweedie <sct@redhat.com>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Raw IO fixes for 2.4.2-ac8
Message-ID: <20010302193856.D28854@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just uploaded the current raw IO fixes as
kiobuf-2.4.2-ac8-A0.tar.gz on

	ftp.uk.linux.org:/pub/linux/sct/fs/raw-io/

and

	ftp.*.kernel.org:/pub/linux/kernel/people/sct/raw-io/

This includes:

00-movecode.diff:	move kiobuf code from mm/memory.c to fs/iobuf.c
02-faultfix.diff:	fixes for faulting and pinning pages
03-unbind.diff:		allow unbinding of raw devices
04-pgdirty.diff:	use the new SetPageDirty to dirty pages after reads
05-bh-err.diff:		fix cleanup of buffer_heads after ENOMEM
06-eio.diff:		fix error returned on EIO in first block of IO

The first 3 of these are from the current 2.2 raw patches.  The 4th is
the fix for dirtying pages after raw reads, using the new
functionality of the 2.4 VM.  The 5th and 6th fix up problems
introduced when brw_kiovec was moved to use submit_bh().

Cheers,
 Stephen
