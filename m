Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCGSW3>; Thu, 7 Mar 2002 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSCGSWU>; Thu, 7 Mar 2002 13:22:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14351 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287817AbSCGSWF>; Thu, 7 Mar 2002 13:22:05 -0500
Message-ID: <3C87AFBE.3000104@zytor.com>
Date: Thu, 07 Mar 2002 10:21:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <505.1015411792@redhat.com> <E16iecJ-0007Nn-00@the-village.bc.nu> <20020306222149.GC370@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!
> 
> 
>>>You say 'at once'. Does UML somehow give pages back to the host when they're 
>>>freed, so the pages that are no longer used by UML can be discarded by the 
>>>host instead of getting swapped?
>>>
>>Doesn't seem to but it looks like madvise might be enough to make that
>>happen. That BTW is an issue for more than UML - it has a bearing on
>>running lots of Linux instances on any supervisor/virtualising system
>>like S/390
>>
> 
> I just imagined hardware which supports freeing memory -- just do not
> refresh it any more to conserve power ;-))).
> 

> Granted, it would probably only make sense in big chunks, like 2MB or
> so... It might make sense for a PDA...
> 									Pavel


Unlikely.  Also, if you're using ECC, then that really screws with you.

However, if it is an issue for more than UML (I still consider the 
particular UML case "in case you have a UML on a tmpfs set up by an 
idiot admin" completely bogus) then it's another issue.  The S/390 issue 
is real.

	-hpa


