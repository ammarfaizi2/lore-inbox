Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUFQRzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUFQRzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUFQRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:55:40 -0400
Received: from [63.81.117.10] ([63.81.117.10]:53835 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261347AbUFQRzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:55:33 -0400
Message-ID: <40D1DAEA.8030103@xfs.org>
Date: Thu, 17 Jun 2004 12:54:50 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Wainwright <prw@ceiriog1.demon.co.uk>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Irix NFS servers, again :-)
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>	 <20040617134424.GA32272@infradead.org> <1087491319.3677.5.camel@ceiriog1.demon.co.uk>
In-Reply-To: <1087491319.3677.5.camel@ceiriog1.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2004 17:55:33.0192 (UTC) FILETIME=[491FA480:01C45494]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wainwright wrote:
> On Thu, 2004-06-17 at 14:44, Christoph Hellwig wrote:
>>
>>IIRC this was fixed on the IRIX side a while ago.  What IRIX version
>>do you run?
>>
> 
> 
> Not very old, it's 6.5.21. And I do have -32bitclients
> in my /etc/exports.
> 
> BTW, I just found an old patch I made for glibc 2.2 to
> fix this (or a similar) problem. Maybe that's a better
> place for a fix
> 

Part of the fix for these issues with Irix NFS was version 2
directories in XFS, this made directory offsets in XFS into
real offsets rather than 64 bit hash values.

If your filesystem is old enough, it will have version 1
directories - and the only conversion process is to do
a dump/mkfs/restore.

xfs_growfs -n /mntpnt will report the directory version
as naming=1 or naming=2 if I recall correctly.

Steve
