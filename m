Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWCBRtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWCBRtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWCBRtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:49:45 -0500
Received: from wp051.webpack.hosteurope.de ([80.237.132.58]:44005 "EHLO
	wp051.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S932257AbWCBRtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:49:45 -0500
Message-ID: <44073037.2090709@steffenweber.net>
Date: Thu, 02 Mar 2006 18:49:43 +0100
From: Steffen Weber <email@steffenweber.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
References: <44071AF3.1010400@steffenweber.net>	 <200603021811.50765.jesper.juhl@gmail.com>	 <44072B88.1020406@steffenweber.net> <9a8748490603020935h4936ae0eob4bcf107cc75c923@mail.gmail.com>
In-Reply-To: <9a8748490603020935h4936ae0eob4bcf107cc75c923@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 3/2/06, Steffen Weber <email@steffenweber.net> wrote:
>> Jesper Juhl wrote:
>>> On Thursday 02 March 2006 17:18, Steffen Weber wrote:
>>>> I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4
>>>> (does not seem to be related to the NFS one):
>>>>
>>>>    CC      mm/mempolicy.o
>>>> mm/mempolicy.c: In function `get_nodes':
>>>> mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
>>>> this function)
>>>> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
>>>> once
>>>> mm/mempolicy.c:527: error: for each function it appears in.)
>>>>
>>> Try the following (untested patch).
>> Thanks for your reply, but this patch does not solve the problem (same
>> error message). I´ve appended my .config in case that might help.
>>
> 
> Hmm, types.h contains the
> 
> #define BITS_PER_BYTE 8
> 
> that mmpolicy.c needs, so including that header should do the trick... odd..
> I'll look at the code a bit more.
There is no BITS_PER_BYTE in include/types.h. I´ve grepped through the 
kernel source (2.6.15 and 2.6.15.5) and found that BITS_PER_BYTE is 
defined only in arch/i386/mach-voyager/voyager_cat.c

Steffen
