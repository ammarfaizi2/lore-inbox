Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUC0XsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUC0XsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:48:05 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:42850 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261937AbUC0Xr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:47:58 -0500
Message-ID: <406612AA.1090406@yahoo.com.au>
Date: Sun, 28 Mar 2004 09:47:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com>
In-Reply-To: <406611CA.3050804@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Nick Piggin wrote:
> 
>> I think 32MB is too much. You incur latency and lose
>> scheduling grainularity. I bet returns start diminishing
>> pretty quickly after 1MB or so.
> 
> 
> See my reply to Bart.
> 
> Also, it is not the driver's responsibility to do anything but export 
> the hardware maximums.
> 
> It's up to the sysadmin to choose a disk scheduling policy they like, 
> which implies that a _scheduler_, not each individual driver, should 
> place policy limitations on max_sectors.
> 

Yeah I suppose you're right there. In practice it doesn't
work that way though, does it?
