Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCPTVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCPTVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:21:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5853 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261400AbUCPTUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:20:34 -0500
Message-ID: <40575374.6080006@pobox.com>
Date: Tue, 16 Mar 2004 14:20:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven J. Hill" <Steve.Hill@timesys.com>
CC: Netdev <netdev@oss.sgi.com>, Tim Hockin <thockin@sun.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
Subject: Re: [PATCH] fix natsemi PCI mapping
References: <40574227.8020302@pobox.com> <4057525E.6020205@timesys.com>
In-Reply-To: <4057525E.6020205@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven J. Hill wrote:
> Jeff Garzik wrote:
> 
>>
>> Somebody wanna review and/or test?
>>
> Hey Jeff.
> 
> I have tested this on 2.4 and it works great on MIPS with one
> minor change below. Remove the 16 byte alignment of the IP
> header. I discovered this when trying to do a BOOTP and mount
> my NFS root filesystem. The BOOTP never succeeds. Patch against
> latest 2.4.25 attached.


Interesting, thanks.

WRT skb_reserve(), I wonder if

(a) RX_OFFSET value passed to skb_reserve() needs to be per-arch
(b) the pre-existing skb_reserve() call is wrong too


