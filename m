Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVI0QIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVI0QIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVI0QIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:08:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:59266 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964997AbVI0QIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:08:39 -0400
Message-ID: <43396E83.7000803@austin.ibm.com>
Date: Tue, 27 Sep 2005 11:08:35 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 4/9] defrag helper functions
References: <4338537E.8070603@austin.ibm.com> <43385594.3080303@austin.ibm.com> <C50046EE58FA62242E92877C@[192.168.100.25]>
In-Reply-To: <C50046EE58FA62242E92877C@[192.168.100.25]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +void assign_bit(int bit_nr, unsigned long* map, int value)
> 
> 
> Maybe:
> static inline void assign_bit(int bit_nr, unsigned long* map, int value)
> 
> it's short enough

OK.  It looks like I'll be sending these again based on the feedback I got,
I'll inline that in the next version.  I'd think with it being static that
the compiler would be smart enough to inline it anyway though.

> 
>>  +static struct page *
>> +fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
>> +{
>> +       /* Stub out for seperate review, NULL equates to no fallback*/
>> +       return NULL;
>> +
>> +}
> 
> 
> Maybe "static inline" too.

Except this is only a placeholder for the next patch, where the function
is no longer short.  I'm going to keep it not inline.
