Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTJBTKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJBTKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:10:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263459AbTJBTK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:10:29 -0400
Message-ID: <3F7C780C.9040001@pobox.com>
Date: Thu, 02 Oct 2003 15:10:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: insecure@mail.od.ua
CC: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@osdl.org>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from 10/1 LSE Call
References: <37940000.1065035945@w-hlinder> <20031001233815.GB29605@work.bitmover.com> <3F7B701C.5020708@pobox.com> <200310022156.49678.insecure@mail.od.ua>
In-Reply-To: <200310022156.49678.insecure@mail.od.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insecure wrote:
> That sounds reasonable, but today's RAM throughput is on the order
> of 1GB/s, not 100Mb/s. 'Out of L1' theory can't explain 100Mb/s ceiling
> it seems.


cp(1) data, at least, will never ever be in L1.  Copying data you need 
to look at the ends of the pipeline -- hard drive throughput, PCI bus 
bandwidth, FSB bandwidth, speed at which ext2/3 allocates blocks, and 
similar things are likely bottlenecks.

You'll never hit RAM bandwidth limits, unless your copies are extremely 
tiny, and entirely in L2 or pagecache.

	Jeff



