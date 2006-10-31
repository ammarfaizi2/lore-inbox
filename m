Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423510AbWJaP5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423510AbWJaP5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423516AbWJaP5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:57:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423510AbWJaP5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:57:30 -0500
Subject: Re: reserve memory in low physical address - possible?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jun Sun <jsun@junsun.net>
Cc: "Richard B. Johnson" <jmodem@abominablefirebug.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061031154019.GC14272@srv.junsun.net>
References: <20061031072203.GA10744@srv.junsun.net>
	 <02f201c6fce8$a660ece0$0732700a@djlaptop>
	 <20061031154019.GC14272@srv.junsun.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 16:01:10 +0000
Message-Id: <1162310470.11965.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-31 am 07:40 -0800, ysgrifennodd Jun Sun:
> On Tue, Oct 31, 2006 at 07:32:37AM -0500, Richard B. Johnson wrote:
> > 
> > You will not be able to reserve any address space starting at 0 anyway, but 
> > your driver or even
> > user-space code can memory-map it.
> > 
> 
> Any reasons or concerns as to why I can't reserve any address space 
> starting from 0?

None at all, Richard is wrong on this point. You can happily reserve
memory starting at physical zero on an x86. In fact the x86 kernel
*already* does this because many BIOSes use the first page for BIOS data
and touch it when we use BIOS services or in SMM.

For a worked example of loading Linux under a small RTOS take a look at
RTLinux, which turns Linux into on task running on a tiny strict RT
kernel.

Alan


