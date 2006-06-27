Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWF0ITS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWF0ITS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWF0ITR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:19:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:38495 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161042AbWF0ITO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:19:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JIrc7+NQLVtZhRAMfwdgGP6oXUv2x4+Tbiu/gLxntq8YOsEyC+ri8pRhkdo7bA7VO6QsEBdqnWWKFMuQLjxMXtaIR9IQJLQuvrjohvpH5GIv5IlmtyRMmQcqsDWt4YeW+NuiMWrQVpQIkd+O7rcZLCoeL8KVP1QgPW5w0PXSSF0=
Message-ID: <44A0EB01.9090809@innova-card.com>
Date: Tue, 27 Jun 2006 10:23:29 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up the bootmem allocator
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Mon, 2006-06-26 at 15:11 +0200, Franck Bui-Huu wrote:
>> This patch does _only_ some cleanup in the bootmem allocator by:
> ...
>>  include/linux/bootmem.h |  101 ++++++++++++++----------
>>  mm/bootmem.c            |  195 ++++++++++++++++++++++++++---------------------
>>  2 files changed, 167 insertions(+), 129 deletions(-)
> 
> I'm always suspicious of "cleanups" which add more code than they remove ;)
> 

it's mainly due to the "80 columns limit" changes

>>         - following the kernel coding style conventions
> 
> Above everything else, this probably needs to be in its very own patch,
> where it is trivially verifiable. 
> 
>>         - using pfn/page conversion macros
>>         - removing some not needed parentheses
>>         - removing some useless included headers
>>         - limiting to 80 column width
> 
> In general, I think there is some good stuff in here.  However, instead
> of concentrating on "kernel coding style conventions" and numeric (80
> column) guidelines, I really hope that people consider _readability_
> when modifying this code.  I don't think this patch makes the code much
> more readable.
> 

well, IMHO using pfn/page conversion macros makes the code more readable.

> That said, there are some nice helper function in here.  Would you be
> able to break this patch up into maybe 10 or 15 smaller patches?  I have
> the feeling it will be easier to find the good bits then.
> 

ok I'll split that.

>> It also removes __init tags in the header file and hopefully make it
>> easier to read. 
> 
> I think I kinda like when these are present in headers.  I usually
> stumble across the header declarations before I do the ones in the .c
> files, and it is always nice to see the header visually _matching_
> the .c file, and how the variable is intended to be used
> 

see Andrew's comments...

		Franck

