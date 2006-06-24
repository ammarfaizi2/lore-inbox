Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWFXEjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWFXEjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWFXEjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:39:47 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:44973 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S932211AbWFXEjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-Kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:39:45 -0400
Message-Id: <5.1.1.5.2.20060624143219.02771e40@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 24 Jun 2006 14:39:45 +1000
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: Measuring tools - top and interrupts
Cc: linux-Kernel@vger.kernel.org, balbir@in.ibm.com
In-Reply-To: <20060624020755.GA6139@atjola.homenet>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
 <20060622162141.GC14682@harddisk-recovery.com>
 <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn,

Yes you have to change the procps to read the new /proc/stat

For example, after separating the load and disk IO measurements, also 
separating for per user at the kernel level, I had to introduce new code 
into procps/ to reflect those changes

Otherwise those tools (top, uptime etc) would not know the new formats etc.

Thanks
Sena
Sydney University


At 04:07 AM 6/24/2006 +0200, you wrote:
>On 2006.06.22 09:58:08 -0700, Danial Thom wrote:
> > And 75K pps may not be "much", but its still at
> > least 10% of what the system can handle, so it
> > should measure around a 10% load. 2.4 measures
> > about 12% load. So the only conclusion is that
> > load accounting is broken in 2.6.
>
>Are you by chance using procps < 3.1.12? The kernel reports absolute
>values for cpu usage, the conversion to percentage is done by top/vmstat
>itself. And those old versions don't know about the new fields that 2.6
>kernels have in /proc/stat, thus they simply ignore the si and hi
>values, producing quite misleading results...
>
>Björn
>
>PS: procps 3.1.12 was released in 2003, so if DEC was stone age and my
>assumption about your tools holds, then your tools are like... medieval :)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

