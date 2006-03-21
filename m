Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWCUSDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWCUSDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWCUSDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:03:51 -0500
Received: from citi.umich.edu ([141.211.133.111]:37417 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932359AbWCUSDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:03:50 -0500
Message-ID: <44204003.6090700@citi.umich.edu>
Date: Tue, 21 Mar 2006 13:03:47 -0500
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfsv4@linux-nfs.org,
       Linus Torvalds <torvalds@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
References: <1142961077.7987.14.camel@lade.trondhjem.org> <20060321174634.GA15827@infradead.org>
In-Reply-To: <20060321174634.GA15827@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------090307090501090709030805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090307090501090709030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
>>commit 47989d7454398827500d0e73766270986a3b488f
>>Author: Chuck Lever <cel@netapp.com>
>>Date:   Mon Mar 20 13:44:32 2006 -0500
>>
>>    NFS: remove support for multi-segment iovs in the direct write path
>>    
>>    Eliminate the persistent use of automatic storage in all parts of the
>>    NFS client's direct write path to pave the way for introducing support
>>    for aio against files opened with the O_DIRECT flag.
> 
> 
> NACK.  We have patches pending that consolidate ->aio_read/write and
> ->read/writev into one operation.  this change is completely counterproductive
> towards that goal which has been discussed on -fsdevel for a while.

and when do you expect these changes to be integrated?  we've had this 
implementation for almost a year, and zach brown has reviewed it.  we 
discussed the aio_read/readv change with him and he agreed that this 
should go in now.

we have major customers who are demanding this functionality now, and 
can support the reimplementation whenever you guys get your aio act 
together.

--------------090307090501090709030805
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------090307090501090709030805--
