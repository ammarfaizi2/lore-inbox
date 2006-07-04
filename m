Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWGDRoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWGDRoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 13:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWGDRoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 13:44:13 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:63105 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932250AbWGDRoN (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 13:44:13 -0400
Message-ID: <44AAA8ED.5030906@namesys.com>
Date: Tue, 04 Jul 2006 10:44:13 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
CC: "Vladimir V. Saveliev" <vs@namesys.com>,
       lkml <Linux-Kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
References: <44A42750.5020807@namesys.com> <20060629185017.8866f95e.akpm@osdl.org> <1152011576.6454.36.camel@tribesman.namesys.com> <20060704114836.GA1344@infradead.org>
In-Reply-To: <20060704114836.GA1344@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Jul 04, 2006 at 03:12:56PM +0400, Vladimir V. Saveliev wrote:
>  
>
>>>Should this be an address_space_operation or a file_operation?
>>>
>>>      
>>>
>>I was seeking to be minimal in my changes to the philosophy of the code.
>>So, it was an address_space operation. Now it is a file operation.
>>    
>>
>
>It definitly should not be a file_operation! It works at the address_space
>not the much higher file level.  Maybe all three should become callbacks
>for the generic write routines, but that's left for the future.
>
>
>  
>
I don't have a commitment to one way or the other, probably because
there are some things that are unclear in my mind.  Could you help me
with them?  Can you define what is the address space vs. the file level
please?  It is odd to be asking such a basic question, but these things
are genuinely unclear to me.  If the use of something varies according
to the file, is it a file method?  What things vary according to address
space and not according to file?  Should things that vary according to
address space be address space ops and things that vary according to
file be file ops?  If that logic seems valid, should a lot more be changed?

Oh, and Andrew, while such things are discussed, could you just pick one
way or the other and let the patch go in?

Hans
