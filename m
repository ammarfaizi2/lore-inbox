Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUK0Xau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUK0Xau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUK0Xau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:30:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:17831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261361AbUK0Xao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:30:44 -0500
Message-ID: <41A90D66.4020204@osdl.org>
Date: Sat, 27 Nov 2004 15:27:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org> <1101575782.21273.5347.camel@baythorne.infradead.org> <200411272353.54056.arnd@arndb.de>
In-Reply-To: <200411272353.54056.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sünnavend 27 November 2004 18:16, you wrote:
> 
>>On Sat, 2004-11-27 at 08:47 -0800, Randy.Dunlap wrote:
>>
>>>Speaking of more explicit, there are various asm-ARCH header
>>>files that do or do not hide (via __KERNEL__) interfaces
>>>such as:      get_unaligned()
>>>and the atomic operations.
>>>
>>>So are these Linux kernel exported APIs, or do they belong
>>>in some library?
>>
>>Both of those are kernel-private and should not be visible.
> 
> 
> The problem with these (atomic.h, bitops.h, byteorder.h, div64.h,
> list.h, spinlock.h, unaligned.h and xor.h) is that they provide
> functionality that is needed by many user application but not
> provided by the compiler or libc. 
> 
> While I agree that it is an absolutely evil concept to include
> them from the kernel headers, we have to face that by not installing
> them, lots of this existing evil user code will be broken even
> more and someone has to pick up the pieces.

That's addressing a different problem.  I agree with
David W. that we need to clean the kernel headers up.
Let libc or libxyz provide the missing functionality.
The borken programs were stealing something that wasn't
promised to them AFAIK.

IOW, let's decide the right thing to do and implement it.

-- 
~Randy
