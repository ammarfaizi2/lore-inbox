Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCaIIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCaIIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCaIIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:08:38 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:9712 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S261163AbVCaIIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:08:21 -0500
Message-ID: <424BA230.3040500@pin.if.uz.zgora.pl>
Date: Thu, 31 Mar 2005 09:09:36 +0200
From: =?ISO-8859-2?Q?Jacek_=A3uczak?= <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Natanael Copa <mlists@tanael.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
References: <20050328172820.GA31571@linux.ensimag.fr>	 <6f6293f105033015467d87993@mail.gmail.com> <1112252134.26074.20.camel@nc>
In-Reply-To: <1112252134.26074.20.camel@nc>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natanael Copa napisa³(a):
> On Thu, 2005-03-31 at 01:46 +0200, Felipe Alfaro Solana wrote:
> 
>>On Mon, 28 Mar 2005 19:28:20 +0200, Matthieu Castet
>><mat@ensilinx1.imag.fr> wrote:
>>
>>>>The memory limits aren't good enough either: if you set them low
>>>>enough that memory-forkbombs are unperilous for
>>>>RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
>>>>applications.
>>>
>>>yes, if you want to run application like openoffice.org you need at
>>>least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...
>>>
>>>I think per user limit could be a solution.
>>>
>>>attached a small fork-memory bombing.
>>
>>Doesn't do anything on my machine:
>>
>># ulimits -a
> 
> ...
> 
> 
>>it tops at 100 processes and eats a little CPU... although the system
>>is under load, it's completely responsive.
> 
> 
> 100 processes is low. I often have over 150.

On desktop system 150 processes is low too. 250 is safe and sufficient 
value.

> I use the patch mentioned here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111209980932023&w=2
> (it set the default max_threads and RLIMIT_NPROC to half of the current
> default)
> 
> and my system survived.

Hmmm....my didn't when nearly all users start forkbombing!

I think that changing the default max_threads is not a good idea. It 
might solve many problems but forkbombing require something more universal.

	Jacek
