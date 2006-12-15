Return-Path: <linux-kernel-owner+w=401wt.eu-S1752920AbWLORBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbWLORBQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbWLORBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:01:16 -0500
Received: from mail.tmr.com ([64.65.253.246]:54201 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbWLORBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:01:15 -0500
Message-ID: <4582D604.5000403@tmr.com>
Date: Fri, 15 Dec 2006 12:06:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jurriaan <thunder7@xs4all.nl>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config
 options
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org> <45813E67.80709@univ-paris12.fr> <1166098747.27217.1018.camel@laptopd505.fenrus.org> <20061214151745.GC9079@thunk.org> <20061214152721.GA5652@amd64.of.nowhere>
In-Reply-To: <20061214152721.GA5652@amd64.of.nowhere>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:
> From: Theodore Tso <tytso@mit.edu>
> Date: Thu, Dec 14, 2006 at 10:17:45AM -0500
>> Remove an (incorrect) assertion that NOHIGHMEM is right for more
>> users, since most systems are coming with at least 1G of memory these
>> days, and even some laptops have up 4G of memory.
> 
> Given this (on a system with 1G of memory, this option shouldn't be
> used)
> 
>>  	  If you are compiling a kernel which will never run on a machine with
>> -	  more than 1 Gigabyte total physical RAM, answer "off" here (default
>> -	  choice and suitable for most users). This will result in a "3GB/1GB"
>> -	  split: 3GB are mapped so that each process sees a 3GB virtual memory
>> -	  space and the remaining part of the 4GB virtual memory space is used
>> -	  by the kernel to permanently map as much physical memory as
>> -	  possible.
>> +	  more than 1 Gigabyte total physical RAM, answer "off" here.
> 
> wouldn't 
> 
> +	  1 Gigabyte or more total physical RAM, answer "off" here.
> 
> make clearer that even with 1G memory, you shouldn't use this option?
> Since 1G is quite common, we should, IMHO, be clear about that case.

Actually, if you want it to be perfectly clear to people who don't keep 
x86 spec sheets in the bathroom for spare time study, a redundant config 
option for NX would be required. Then the logic would be:
    PAE = MEM>4G || NX
as far as the actual build was concerned. Or you could reject NX in 
config unless PAE was selected.

I don't think you will avoid confusion when you have two unrelated 
reasons for enabling the same feature.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
