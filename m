Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269429AbUI3S4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269429AbUI3S4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUI3SyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:54:08 -0400
Received: from mail.tmr.com ([216.238.38.203]:13063 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269415AbUI3SxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:53:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: OSDL aio-stress results on latest kernels show buffered random
 read   issue
Date: Thu, 30 Sep 2004 14:54:30 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhk8n$6bv$2@gatekeeper.tmr.com>
References: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096569943 6527 192.168.12.100 (30 Sep 2004 18:45:43 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith Lebzelter wrote:
> Hello;
> 
> I am running aio-stress on the most recent kernels and have
> found that on linux-2.6.8, 2.6.9-rc2 and 2.6.9-rc2-mm4 the
> performance of buffered random reads is poor compared to the
> buffered random writes:
> 
>                2.6.8      2.6.9-rc2     2.6.9-rc2-mm4
>              --------------------------------------------
> random write 35.66 MB/s   34.80 MB/s    29.89 MB/s
> random read   7.69 MB/s    7.50 MB/s     7.68 MB/s
> 
> ** 2CPU hosts with striped Megaraid. 1G RAM. 4G File.
> 
> 
> This shows up on our 4CPU host as well. (striped AACRAID.4G
> RAM. 8G File):
>              2.6.9-rc2     2.6.9-rc2-mm4   2.6.9-rc2-mm1
>              -------------------------------------------
> random write 31.36 MB/s     18.92 MB/s      18.97 MB/s
> random read  11.13 MB/s      9.74 MB/s      11.05 MB/s
> 
> 
> There seems to be an issue with the reads.  Usually, reads
> should be at least as fast as writes of the same type.

Usually not, since the write goes to cache in most cases while the read 
must really happen. The 40% slowdown is troubling, though, that's 
unexpected.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
