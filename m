Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVAKSjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVAKSjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVAKSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:39:54 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:34669 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261555AbVAKSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:39:52 -0500
Message-ID: <41E41D77.7000305@sbcglobal.net>
Date: Tue, 11 Jan 2005 13:39:51 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: address space reservation functionality?
References: <41E2EB09.5000603@sbcglobal.net> <1105429362.3917.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1105429362.3917.2.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not quite the same thing.  This still does a check for whether 
or not there is enough memory and includes this in the virtual size of 
the process.  I simply want to reserve a part of the address space so 
I'm guaranteed I can map something else over a contiguous portion of the 
address space.  I don't want it to check for available memory or 
increase the virtual size of the process because I will be using this 
region sparsely.  That is why Solaris and Windows have separate 
interfaces for this.

Arjan van de Ven wrote:
> On Mon, 2005-01-10 at 15:52 -0500, Robert W. Fuller wrote:
> 
>>Hi,
>>
>>I was wondering if some functionality existed in Linux.  Specifically, 
>>in Solaris, you can mmap the null device in order to reserve part of the 
>>address space without otherwise consuming resources.  This is detailed 
>>in the Solaris manpage null(7D).  The same functionality is also 
>>available under Windows NT/XP/2K by calling the VirtualAlloc function 
>>with the MEM_RESERVE flag omitting the MEM_COMMIT flag.  Does Linux have 
>>a similar mechanism buried somewhere whereby I can reserve a part of the 
>>address space and not increase the "virtual size" of the process or the 
>>system's idea of the amount of memory in use?  I could not find one by 
>>using the source.
> 
> 
> malloc() already does this...
> what you describe is the default behavior of linux; only when you
> actually write to the memory does it get backed by ram.
