Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTL3GNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTL3GMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:12:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264411AbTL3GMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:12:41 -0500
Message-ID: <3FF11745.4060705@pobox.com>
Date: Tue, 30 Dec 2003 01:12:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
References: <1072567054.4112.14.camel@gaston>	<20031227170755.4990419b.davem@redhat.com>	<3FF0FA6A.8000904@pobox.com>	<20031229205157.4c631f28.davem@redhat.com>	<20031230051519.GA6916@gtf.org> <20031229220122.30078657.davem@redhat.com>
In-Reply-To: <20031229220122.30078657.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 30 Dec 2003 00:15:19 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>OK, agreed.  But fixing it in the driver is still incorrect, also.
>>
>>We need a single solution in the net stack, not a per-driver solution.
> 
> 
> I totally disagree.
> 
> Let's quickly review, this is illegal:


You're missing the point.

Think about the name of this function:  dev_kfree_skb_any()

If this function cannot be used -anywhere-, then the concept (and the 
net stack) is fundamentally broken for this function.  We must _remove_ 
the function, and thus _I_ have a lot of driver work to do.

[jgarzik@sata linux-2.5]$ find . -name '*.[ch]' -type f | grep -v SCCS | 
xargs grep -wl dev_kfree_skb_any | wc -l
      71

	Jeff



