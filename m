Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLWP3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTLWP3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:29:49 -0500
Received: from linuxhacker.ru ([217.76.32.60]:20941 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261595AbTLWP3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:29:47 -0500
Date: Tue, 23 Dec 2003 17:20:14 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Carlo <devel@integra-sc.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
Message-ID: <20031223152014.GG2099@linuxhacker.ru>
References: <1072126808.21200.3.camel@atena> <200312222205.hBMM5vLv012067@car.linuxhacker.ru> <1072173894.21198.36.camel@atena>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072173894.21198.36.camel@atena>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Dec 23, 2003 at 11:04:59AM +0100, Carlo wrote:
> > C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> > C> DataRequest }
> > C> ide0: Drive 0 didn't accept speed setting. Oh, well.
> > C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > C> hda: CHECK for good STATUS
> > Do you always get these IDE errors prior to oops?
> No, on 6 oops only one has this error!

Ah, I see.

> > C> Unable to handle kernel paging request at virtual address ffffffe0
> ............
> > Also please run your oops through ksymoops.
> >>EIP; c0146553 <select_parent+33/a0>   <=====
> Trace; c01465dd <shrink_dcache_parent+1d/30>
> Trace; c013fa0f <d_unhash+2f/50>
> Trace; c018d840 <reiserfs_rmdir+0/270>
> Trace; c013fb69 <vfs_rmdir+139/1c0>
> Trace; c013fc84 <sys_rmdir+94/e0>
> Trace; c0114d00 <do_page_fault+0/48c>
> Trace; c01088a3 <system_call+33/38>

Sounds like a list corruption to me.
Are you sure the memory in that box is ok?

> If it's necessary i can send the full /var/log/messages  passed through
> ksymoops with a lot of "Unable to handle kernel paging request at
> virtual address" but it's aboute 500Kb.

Run it through ksymoops and see if backtrace is different each time.
Usually only first oops per boot is useful.
If backtrace is different each time, perhaps list all unique oopses?

Thank you.

Bye,
    Oleg
