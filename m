Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbUK0AQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUK0AQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbUK0AQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:16:11 -0500
Received: from hermes.domdv.de ([193.102.202.1]:30724 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S263107AbUK0ANQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:13:16 -0500
Message-ID: <41A7C68D.3060302@domdv.de>
Date: Sat, 27 Nov 2004 01:13:01 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Matthew Wilcox <matthew@wil.cx>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk> <1101422103.19141.0.camel@localhost.localdomain>
In-Reply-To: <1101422103.19141.0.camel@localhost.localdomain>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Thu, 2004-11-25 at 21:01 +0000, Matthew Wilcox wrote:
> 
>>I'm not particularly stuck on the <user/> namespace.  We could invent
>>a better name.  How about <kern/> and <arch/> to replace <linux/>
>>and <asm/>?  Obviously keeping linux/ and asm/ symlinks for backwards
>>compatibility.
> 
> 
> There's no _real_ need to keep them. All we need to fix is a handful of
> libc implementations; anything else using them was broken anyway.
> 
<rant mode>

Cute idea. So any new definition which is supposed to be used in 
userspace will take at least a year to propagate - well, I know, one can 
always look for the definition in the kernel headers, copy it, ...
Now this is no solution.

And how do you want to deal with the fact that up to now all the 
netfilter headers required for userspace programming live in the kernel 
include tree? Now this has been like this for quite some years. Shall 
one no longer use netfilter?

It is easy to be happy with the status quo and to reject any attempt to 
change things for the better. If you really wanted to fix (g)libc you 
would have taken action long ago. You're around for long enough.

</rant mode>
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
