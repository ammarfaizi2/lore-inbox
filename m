Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269441AbUJLEI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269441AbUJLEI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269443AbUJLEI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:08:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:21706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269441AbUJLEIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:08:25 -0400
Message-ID: <416B57DE.4070605@osdl.org>
Date: Mon, 11 Oct 2004 21:04:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: __init dependencies
References: <20041010225717.GA27705@redhat.com>	<Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be> <20041011121225.2f829507.akpm@osdl.org> <416ADC63.6010709@osdl.org>
In-Reply-To: <416ADC63.6010709@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Andrew Morton wrote:
> 
>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>>> I guess it's about time for a tool to autodetect __init dependencies?
>>
>>
>>
>> `make buildcheck' does this.  Looks like nobody is using it.
> 
> 
> I have asked that one of the forever-building machines here (OSDL)
> do that.
> I'll get back to that request....

John Cherry has been running 'make buildcheck' regularly,
but apparently nobody has been looking.

Latest (2.6.9-rc4) is here:
http://developer.osdl.org/cherry/compile/2.6/linux-2.6.9-rc4.results/2.6.9-rc4.reference_init26.bzImage.txt

My experience with output of buildcheck is that it's verbose and has
lots of false positives.  (Yes, I have used it and generated patches
from it.)  First thing I do is delete all lines that match
"data.*init" or "data.*exit".  These are (usually -- famous word) OK.
Then someone can look at the entries that really need to be checked,
such as this list, derived from the larger list above:

http://developer.osdl.org/rddunlap/doc/2.6.9-rc4.reference_init26.bzImage.txt

I'll look over it in the next few days.

-- 
~Randy
