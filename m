Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUAMXmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUAMXmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:42:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:11668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265689AbUAMXmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:42:31 -0500
Date: Tue, 13 Jan 2004 15:43:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Haakon Riiser <hakonrk@ulrik.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-Id: <20040113154348.5542cb7b.akpm@osdl.org>
In-Reply-To: <20040113232624.GA302@s.chello.no>
References: <20040113210923.GA955@s.chello.no>
	<20040113135152.3ed26b85.akpm@osdl.org>
	<20040113232624.GA302@s.chello.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haakon Riiser <hakonrk@ulrik.uio.no> wrote:
>
> > Seems innocuous.  What filesystem type is lock/trigger on?
> 
> Reiserfs.
> 
> > Can you generate a kernel profile of this activity?
> 
> Done.  Note that I had to reboot to do the profiling, so the
> delay is not as bad as the first example:
> 
>   344   00:19:07.476825 write(5, "\0", 1) = 1 <0.291500>
> 
> Still around 700 times slower than 2.4 though. :-)  Anyway,
> here are the results:
> 
> Output from time:
> 
>   real    0m0.309s
>   user    0m0.011s
>   sys     0m0.004s
> 
> Data in prof.time:

OK, that's inconclusive.  Could you do a few runs, or leave it a day or
two, wait until the problem is really prominent and see if you can gather a
clearer profile?  The profiling overhead is negligible when profiling is
enabled but not in use, so there is no need to reboot.


Thanks.
