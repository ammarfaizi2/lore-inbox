Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272060AbTHMXzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHMXy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:54:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:22155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272053AbTHMXyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:54:54 -0400
Date: Wed, 13 Aug 2003 16:51:04 -0700
From: Greg KH <greg@kroah.com>
To: Clemens Schwaighofer <gullevek@gullevek.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-cvs: still a small oops afer boot
Message-ID: <20030813235104.GC7863@kroah.com>
References: <200308121010.11139.gullevek@gullevek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308121010.11139.gullevek@gullevek.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 10:10:10AM +0900, Clemens Schwaighofer wrote:
> hi
> 
> cvs from 2003/08/12
> 
> right after boot I still get this
> 
> eth0: Media Link On 100mbps full-duplex
> Badness in pci_find_subsys at drivers/pci/search.c:132
> Call Trace:
>  [<c026515d>] pci_find_subsys+0xdd/0x100
>  [<c0265195>] pci_find_device+0x15/0x20
>  [<c02e1551>] sis630_set_eq+0x51/0x260
>  [<c02e17f2>] sis900_timer+0x92/0x1a0
>  [<c02e1760>] sis900_timer+0x0/0x1a0
>  [<c0122649>] run_timer_softirq+0xc9/0x1a0
>  [<c011e604>] do_softirq+0xa4/0xc0
>  [<c010ae4a>] do_IRQ+0x10a/0x140
>  [<c0105000>] _stext+0x0/0x60
>  [<c01094f8>] common_interrupt+0x18/0x20
>  [<c01070a0>] default_idle+0x0/0x40
>  [<c0105000>] _stext+0x0/0x60
>  [<c01070c7>] default_idle+0x27/0x40
>  [<c0107149>] cpu_idle+0x29/0x40
>  [<c052e6e8>] start_kernel+0x128/0x140

Try the patch at:
	http://bugme.osdl.org/show_bug.cgi?id=923

It should fix it.

thanks,

greg k-h
