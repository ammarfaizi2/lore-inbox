Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTFBEyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFBEyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:54:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13495 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261864AbTFBEyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:54:37 -0400
Date: Mon, 2 Jun 2003 10:40:30 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70] possible problem with /dev/diskstats
Message-ID: <20030602051030.GB1256@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200306010035.58957.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306010035.58957.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 10:40:21PM +0000, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi.
> 
> I've just played around with my server (that has actualy no load)
> and I recognized something strange in /dev/diskstats.
> 
> Documentation/iostats.txt says about diskstats:
> [SNIP]
> Field  9 -- # of I/Os currently in progress
>     The only field that should go to zero. Incremented as requests are
>     given to appropriate request_queue_t and decremented as they finish.
> [SNIP]
> 
> But here is a cat /proc/diskstats:
>    1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
>    1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
>    1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
>    1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
>    1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
>    1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
>    1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
>    1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
>    1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
>    1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
>    1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
>    1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
>    1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
>    1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
>    1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
>    1   15 ram15 0 0 0 0 0 0 0 0 0 0 0

Rick,

ramdisk stats are also always zero whether you do any IO or not. Any idea
where this can be corrected.

Thanks
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
