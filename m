Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTIAUmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTIAUmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:42:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34226 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263263AbTIAUmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:42:52 -0400
Date: Mon, 1 Sep 2003 17:45:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.22
In-Reply-To: <Pine.LNX.4.53.0308261327540.229@chaos>
Message-ID: <Pine.LNX.4.44.0309011743420.6008-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Aug 2003, Richard B. Johnson wrote:

> 
> I configured, built and booted Linux-2.4.22. There are
> some problems.
> 
> (1) `dmesg` fails to read the first part of the buffered
> kernel log. I have attached two files, dmesg-20 (normal)
> and dmesg-22 (bad). File dmesg-22 is from Linux-2.4.22
> and dmesg-20 is from Linux-2.4.20. To save space, I
> snip everything after 'NET4'.
> 
> (2)  The ipx module fails to load with undefined symbols.
> This module loads fine in Linux-2.4.20.
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipx/ipx.o
> depmod: 	unregister_8022_client
> depmod: 	make_EII_client
> depmod: 	register_8022_client
> depmod: 	register_snap_client
> depmod: 	make_8023_client
> depmod: 	destroy_8023_client
> depmod: 	destroy_EII_client
> depmod: 	unregister_snap_client

> (3)  When umounting the root file-system, the machine usually
> hangs. The result is a long `fsck` on the next boot. The problem
> seems to be that sendmail doesn't get killed during the `init 0`
> sequence. It remains with a file open and the root file-system isn't
> unmounted. A temporary work-round is to `ifconfig eth0 down` before
> starting shutdown. Otherwise, sendmail remains stuck in the 'D' state.

Which previous kernel didnt show this behaviour? 

> 
> (4)  When mounting the DOS file-systems during startup, the echo
> on the screen shows about 15 lines of white-space. This never
> happened before. When mounting /proc, there are 6 lines of
> white-space, also strange.

Again, which kernel doesnt show that behaviour? 

Thanks

