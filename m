Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUKKIfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUKKIfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 03:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUKKIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 03:35:20 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:53152 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbUKKIfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 03:35:12 -0500
Message-ID: <4193243D.3000201@yahoo.com.au>
Date: Thu, 11 Nov 2004 19:35:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hindley <mark@hindley.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.6.9
References: <20041110074851.GA9757@titan.home.hindley.uklinux.net> <4191D13C.3060308@yahoo.com.au> <20041111072734.GA1671@titan.home.hindley.uklinux.net>
In-Reply-To: <20041111072734.GA1671@titan.home.hindley.uklinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> On Wed, Nov 10, 2004 at 07:28:44PM +1100, Nick Piggin wrote:
>  
> 
>>   a9 40 00 00 00            test   $0x40,%eax
>>   74 08                     je     33 <_EIP+0x33>
>>   0f 0b                     ud2a
>>
>>So eax (20001045) is page->flags, which is
>>PG_locked | PG_referenced | PG_active | PG_private, I think.
>>
>>You might have flipped a bit. Can you run memtest86 on the system overnight?
>>
> 
> 
> Ran for 12 hours overnight. Extended tests, no errors.
> 

OK, it's just that it's a pretty common path in the kernel, and if
there was a bug there you'd be very unlucky to be the only one
hitting it. Still, it's possible. Probably the best thing to do is
report it if it happens again.

Oh, what sort of system is it? CPU, how much RAM, etc?

Sorry I can't be of more help.
