Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbUKRMK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUKRMK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbUKRMK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:10:59 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:19891 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262748AbUKRMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:10:53 -0500
Message-ID: <419C9144.2080605@yahoo.com.au>
Date: Thu, 18 Nov 2004 23:10:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Morten W. Petersen" <morten@nidelven-it.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fixing page allocation failure
References: <419C8756.3080709@nidelven-it.no>
In-Reply-To: <419C8756.3080709@nidelven-it.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten W. Petersen wrote:
> Hi all,
> 
> I have a server that a couple of times each day squirts out messages 
> about page allocation failures (python: page allocation failure. 
> order:3, mode:0x20).  What's the reason for this, and could it affect 
> the stability of the box?
> 
> The server that squirts these messages just crashed, for no apparent 
> reason, so that's why I'm wondering.  It's a UML box.  Also, I'm 
> wondering, are there any howto's for tweaking /proc settings so that the 
> machine becomes more stable?  Are there any settings for increasing the 
> verbosity of the kernel log so that the reason for a server crashing is 
> easier to find?
> 
> Thanks in advance, and please CC me any replies :)
> 
> Regards,
> 
> Morten

Yeah you can increase /proc/sys/vm/min_free_kbytes to help the problem.

There is a possibly better solution in the -mm kernels which should get
merged into 2.6 sooner or later - but there is still no way to guarantee
safety from allocation failures. If they cause crashes then that is a
bug, so report them here with traces and a description of the workload
and system hardware, etc.

Thanks
Nick
