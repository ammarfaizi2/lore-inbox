Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVD0Q5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVD0Q5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVD0Q5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:57:33 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24483 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261803AbVD0Q5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:57:31 -0400
Message-ID: <426FC46C.4070306@nortel.com>
Date: Wed, 27 Apr 2005 10:57:16 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: any way to find out kernel memory usage?
References: <426FBFED.9090409@nortel.com> <426FC0FE.2090900@oktetlabs.ru>
In-Reply-To: <426FC0FE.2090900@oktetlabs.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityuckiy wrote:
> Chris Friesen wrote:
>>  Is 
>> there any way to find out how much memory the kernel is using?  I 
>> don't see anything in /proc, but maybe something internal that isn't 
>> currently exported?
>>
> How about /proc/slabinfo ?

Hmm...if I'm reading that correctly, I should be able to get the total 
kernel memory usage by summing up

num_slabs*pagesperslab

for all listed slabs.  Does that sound right?

I assume kmalloc/vmalloc use the "size-x" slabs?


Chris
