Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWCGAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWCGAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCGAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:14:57 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752055AbWCGAO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:14:56 -0500
Message-ID: <440D40F6.4030803@us.ibm.com>
Date: Tue, 07 Mar 2006 00:14:46 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rc5-mm2 mpage_readpages() cleanup
References: <1141684312.17095.11.camel@dyn9047017100.beaverton.ibm.com> <20060306143718.50fc0d94.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>>Instead of passing validity of block mapping, do_mpage_readpage() 
>> can figure it out using buffer_mapped(). This will reduce one
>> un-needed argument passing.
>>
>
>Is buffer_mapped() the correct flag to use?  Remember that get_block() can
>validly return a !buffer_mapped() bh over a file hole.
>
Yes. Currently the code which handles hole can only deal with a single 
block at a time.
All I am trying to do is,  find out when to do next getblock() call.

>
>Either way, there should be a comment in there explaining the protocol,
>please.
>
Will do.

Thanks,
Badari



