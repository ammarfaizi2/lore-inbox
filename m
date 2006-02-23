Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWBWE21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWBWE21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWBWE20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:28:26 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:32191 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750826AbWBWE20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:28:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l7TuMXkfZ6851wjIjKLcTGz2WtFClTOEmJCbGdPwhLuqRYEt8kyGYh3PVSnEgyBrWtGCaxCqjoT81leiknmCLsKiIvAlNpCsm9fV0/ZPKWeDxmrMeiwDCSM4gI/f0GZeGTjSWJtzqbwSqr6I5EuwcGdMS35MdbrUum14O8ISx2s=  ;
Message-ID: <43FD39E6.7050701@yahoo.com.au>
Date: Thu, 23 Feb 2006 15:28:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC][patch] mm: single pcp lists
References: <20060222143217.GI15546@wotan.suse.de> <43FCE394.9010502@austin.ibm.com>
In-Reply-To: <43FCE394.9010502@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:
>> -struct per_cpu_pages {
>> +struct per_cpu_pageset {
>> +    struct list_head list;    /* the list of pages */
>>      int count;        /* number of pages in the list */
>> +    int cold_count;        /* number of cold pages in the list */
>>      int high;        /* high watermark, emptying needed */
>>      int batch;        /* chunk size for buddy add/remove */
>> -    struct list_head list;    /* the list of pages */
>> -};
> 
> 
> Any particular reason to move the list_head to the front?
> 

Nothing particular. I think it was for alignment at one stage
before cold_count was added.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
