Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSGSXDJ>; Fri, 19 Jul 2002 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGSXDJ>; Fri, 19 Jul 2002 19:03:09 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:8905 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317189AbSGSXDI>; Fri, 19 Jul 2002 19:03:08 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C4460283E2F5@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'J.A. Magallon'" <jamagallon@able.es>, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.19rc2aa1
Date: Fri, 19 Jul 2002 16:05:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamagallon wrote:

> >diff between 2.4.19rc1aa2 and 2.4.19rc1aa2:
> >
> >Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
> >Only in 2.4.19rc2aa1: 000_e100-2.1.6.gz
> >Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
> >Only in 2.4.19rc2aa1: 000_e1000-4.3.2.gz
> >

>More on this.

>We have two interfaces:
>04:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
03:01.0 Ethernet
>controller: Intel Corp. 82543GC Gigabit Ethernet Controller (rev 02)

>NetPipe (tcp) shows numbers like 80Mb/s for e100 and 500Mb/s for e1000. So
efficiency is much >much higher for e100 driver+card than e1000. I have to
dig, perhaps e100 is doing zerocopy and >e1000 is not ?

>Any ideas ?

If e100 is sending from the zerocopy path, e1000 is doing the same.

There are several factors that may be limiting your throughput on e1000.
Assuming you have enough CPU umph and bus bandwidth, and your netpipe link
partner and switch are willing, you should be able to approach wire speed.

-scott
