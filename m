Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271849AbTG2Pdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271850AbTG2Pde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:33:34 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:56849 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271849AbTG2Pdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:33:33 -0400
Message-ID: <3F26964B.3070900@techsource.com>
Date: Tue, 29 Jul 2003 11:44:11 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>            <3F2682EF.2040702@techsource.com> <200307291528.h6TFSo3o004775@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

> 
> Well.,.. it turns out I was half right, sort of.  My remaining glitches *were*
> I/O related rather than the CPU scheduler.  However, they weren't directly
> related to the /sys/block/hda/queue/iosched/* values.
> 
> Turns out that at least on this laptop, 256M is just a bit tight on memory under
> some conditions (well... OK... having X and xmms running, and then doing a
> 'tar xjvf linux-2.6.0-test1.tar.bz2' and launching OpenOffice 1.1rc1 all at once
> is probably a stress test and a half ;).
> 
> Watching /proc/vmstat, it became obvious that audio skips were happening *only*
> when 'pswpout' was going up - which means somebody's waiting on a page *IN*
> that won't happen till another page goes *out* to swap first.....
> 
> Time for more pondering.. ;)

Heh... can we prioritize swapping based on interactivity information?  :)

