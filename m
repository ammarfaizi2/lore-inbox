Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTLJCvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTLJCvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:51:08 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:48022 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S263376AbTLJCvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:51:04 -0500
Message-ID: <3FD68A14.90500@wanadoo.es>
Date: Wed, 10 Dec 2003 03:51:00 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: bad performance on 2.4.23
References: <Pine.LNX.4.44.0312081101030.1289-100000@logos.cnet>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> About the high numbers on -ac and -aa:
> 
> -ac includes rmap and the drop_behind() logic (I just posted the patch
> against 2.4.23 to lkml). I believe its the reason for the read slowdowns
> reported on lkml.
> 
> -aa includes this patch which will increase the max readahead 
> significantly. Mind trying it?

Sorry. I don't have any free machine to do this kind of tests. :(

>>In 'Sequential Reads' and 'Sequential Writes', 'Maximum Latency' is _too much high_
>>
>>2.4.23-pre4                   8192  4096  256    5.10  6.83%   430.551  1602091.53  0.35501  0.31585     75
>>2.4.23-rc1                    8192  4096  256    5.04  6.94%   432.486  1937701.66  0.33408  0.29884     73

> Now this is really odd. When did it started happening?

It looks like between .20 and .23, included.

Test was done by Randy Hron <rwhron@earthlink.net> over a OSDL server:
4x700 mhz Pentium III Xeons with 1MB cache 3.75 GB RAM
DAC960 Fiber channel to SCSI disks in RAID5 configuration
more details at http://home.earthlink.net/~rwhron/kernel/bigbox.html

what is very strange is that in two different tests and kernels
(2.4.23-pre4 and2.4.23-rc1) 'Maximum Latency' is very high with
256 threads.

