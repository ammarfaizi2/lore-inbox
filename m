Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUHHSlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUHHSlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUHHSlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:41:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:23264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266128AbUHHSlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:41:08 -0400
Date: Sun, 8 Aug 2004 11:39:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
Message-Id: <20040808113930.24ae0273.akpm@osdl.org>
In-Reply-To: <200408081030.39051.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
	<200408081030.39051.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> On Thursday 05 August 2004 23:24, Linus Torvalds wrote:
> 
> [...]
> 
> >I'll commit the obvious one-liner fix, since it might explain _some_
> >problems people have seen.
> >
> >		Linus
> 
> I had to reboot late last night, out of memory and things (like 
> mozilla (1.7.2) were dying, but nothing in the logs.

Please wait for it to happen again, then send the contents of
/proc/meminfo, /proc/slabinfo and then do

	su
	dmesg -c
	echo m > /proc/sysrq-trigger
	dmesg > foo

and send foo as well.
