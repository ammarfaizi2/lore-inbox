Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbVFYDQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbVFYDQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVFYDQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:16:51 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25542 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263308AbVFYDPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:15:52 -0400
Message-ID: <42BCCC5B.2030901@pobox.com>
Date: Fri, 24 Jun 2005 23:15:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42BCBB60.7000508@comcast.net> <42BCBF01.206@comcast.net> <42BCC257.5060900@comcast.net>
In-Reply-To: <42BCC257.5060900@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Sorry, i'm retarded, i pasted the wrong changelog line.
> 
> <hch@lst.de>
>     [8139TOO]: Use rtnl_lock_interruptible()
>     
>     The 8139too thread needs to use rtnl_lock_interruptible so it can avoid
>     doing the actual work once it's been kill_proc()ed on module removal
>     time.
>     
>     Based on debugging and an earlier patch that adds a driver-private
>     semaphore from Herbert Xu.
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> This seems to be the only patch that contains a change to the 8139too 
> code between working and non-working code.

Please verify that reverting this patch actually fixed your problem.

$subject talks about 8139cp, but you list a change to 8139too, which are 
two different drivers.

It's often wrong to focus on the driver.  If a driver suddenly stops 
working, that may indicate a problem in the interrupt subsystem, etc.

	Jeff


