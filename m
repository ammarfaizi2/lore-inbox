Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVJCQs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVJCQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVJCQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:48:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53404 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932618AbVJCQs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:48:56 -0400
Message-ID: <434160ED.7050803@pobox.com>
Date: Mon, 03 Oct 2005 12:48:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com> <43413CE8.1090306@adaptec.com> <434154F0.9070105@pobox.com> <43415AFC.5080501@adaptec.com>
In-Reply-To: <43415AFC.5080501@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 10/03/05 11:57, Jeff Garzik wrote:
> 
>>>From what I see, because of its *layering* position
>>
>>>JB's "transport attributes" cannot satisfy open transport.
>>
>>
>>Repeating verbatim the above quote:  a transport class is more than just 
>>transport attributes.
> 
> 
> a) "Transport Attributes" _is_ its name,

No, transport class is its name.  Think about a standard object-oriented 
paradigm.  Each transport has unique characteristics.  The proper place 
to export these and manage these characteristics is the transport layer, 
as SAM agrees.  The manifestation of the transport layer is the 
transport class.

You have to look beyond the current code, to see this.

An implementation of a transport class, in conjunction with helper 
functions common to all transports (SCSI core), combines to form the 
transport layer for a specific transport.


> b) It sits across SCSI Core, i.e. on the same level.
> c) It was never intended to add management.

SCSI core is nothing but a set of helper functions and support code that 
enable the transport class and LLDD to implement the transport layer.


> d) Its inteface to SCSI Core is badly defined and an "invention",
>    (and very poor at that).

Strongly disagree.  This invention is defined by -needs-, as is other 
code in Linux.  If we have new needs, we change the code.


> The reason for d) is that
> 2) does _not_ follow _any_ spec or standard.

That's fine, since its an internal kernel API.

	Jeff


