Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269438AbUHZTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269438AbUHZTSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUHZTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:14:38 -0400
Received: from eagle.rtlogic.com ([216.87.68.236]:57775 "EHLO
	eagle.rtlogic.com") by vger.kernel.org with ESMTP id S269435AbUHZTMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:12:02 -0400
Message-ID: <412E35F2.30501@rtlogic.com>
Date: Thu, 26 Aug 2004 13:11:46 -0600
From: David Rolenc <drolenc@rtlogic.com>
Reply-To: drolenc@rtlogic.com
Organization: RT Logic!
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
References: <412E2058.60302@rtlogic.com> <412E2E0D.8040401@dgreaves.com>
In-Reply-To: <412E2E0D.8040401@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:

> David Rolenc wrote:
>
>> I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior 
>> in 2.6 and just a glance at fadvise.c suggests that 
>> POSIX_FADV_NOREUSE is not implemented any differently than 
>> POSIX_FADV_WILLNEED. Am I missing something?  I want to read data 
>> from disk with readahead and drop the data from the page cache as 
>> soon as I am done with it. Do I have to call fadvise with 
>> POSIX_FADV_DONTNEED after every read?
>
>
> And will this work over nfs?

The system will not be using nfs at all.

>
> David
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


