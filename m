Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWBGLIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWBGLIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWBGLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:08:53 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57730 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965019AbWBGLIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:08:52 -0500
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <safemode@comcast.net>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, harald.dunkel@t-online.de,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
In-Reply-To: <43E8150E.9030801@comcast.net>
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
	 <43E3D103.70505@comcast.net>
	 <Pine.LNX.4.58.0602060836520.1309@shark.he.net>
	 <43E7A4C0.4020209@t-online.de>
	 <1139255800.10437.51.camel@localhost.localdomain>
	 <43E805D4.5010602@comcast.net> <43E7F73E.2070004@comcast.net>
	 <43E7F73E.2070004@comcast.net> <20060206173520.43412664.akpm@osdl.org>
	 <E1F6I3G-0003fw-00@chiark.greenend.org.uk>  <43E8150E.9030801@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 11:10:29 +0000
Message-Id: <1139310629.18391.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 22:33 -0500, Ed Sweetman wrote:
> first from the testing branch to the upstream patches.   In mm, sata 
> gets loaded before pata in libata land.  In alan cox's patches it's the 
> reverse.  This results in different device names for the same config 

Thats just down the shape of the Makefile. It'll get resolved in the
merge of the code upstream over time according to the order Jeff puts
them in

> Perhaps from a distribution standpoint, moving to a label method of 
> describing what gets mounted where would be best, rather than worrying

One reason I've not worried about this is I use Fedora so it "just
works"

> about scsi naming schemes or ide ones.  Just think of the fun of a 
> system with multiple usb storage devices and such.  
> I'm just not sure if grub and the kernel "root=" parameter can handle it.

They can't but they don't need too. See the Fedora/Red Hat mkinitrd
script and tools. The 'root' is the initrd and the tools it contains
find the real root by label. No kernel hackery needed.

