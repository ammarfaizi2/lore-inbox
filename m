Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269654AbUICMAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269654AbUICMAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUICMAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:00:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269645AbUICMAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:00:19 -0400
Message-ID: <41385CC2.9020703@pobox.com>
Date: Fri, 03 Sep 2004 08:00:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NM Lists <mlists@paris.monnet.biz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with Promise Driver, still in 2.6.9-rc1
References: <1094204856.18563.7.camel@nicathlon.monnet.biz>
In-Reply-To: <1094204856.18563.7.camel@nicathlon.monnet.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NM Lists wrote:
> This has already been reported I think, but here it is again. In some
> bugzilla somewhere this has been incorrectly reported as a software Raid
> vs. Promise driver incompatibility; in fact, it appears to be a problem
> when both SATA channels are being used at the same time (which obviously
> happens a lot with raid!)
> 
> How to trigger it:
> 
> # cat /dev/sda > /dev/null &
> # hdparm -t /dev/sdb &
> # hdparm -t /dev/sda &


Well, I'm not familiar with this problem, at least.

Can you provide info as described in REPORTING-BUGS (in the kernel tree)?

Can you define ATA_DEBUG and ATA_VERBOSE_DEBUG in 
include/linux/libata.h, and provide output when it deadlocks?

Did you try 2.6.9-rc1 snapshot?

If nothing else, can you record the bug at http://bugzilla.kernel.org/ 
to make sure its not lost?

	Jeff


