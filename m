Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWGBRpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGBRpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWGBRpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:45:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:1723 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751683AbWGBRpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:45:34 -0400
Message-ID: <44A80614.3090802@zytor.com>
Date: Sun, 02 Jul 2006 10:44:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Miles Lane <miles.lane@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <fa.iPhEst5K48JbrGWRr3l3/GEBesY@ifi.uio.no> <fa.iffnN5wM1UwqtCYhmqLAkGCMC2o@ifi.uio.no> <44A802FE.2020203@shaw.ca>
In-Reply-To: <44A802FE.2020203@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Miles Lane wrote:
>> Well, from the web page referenced at the top of this message, you
>> can see that they are already aware of these issues:
>>
>> Cons:
>>    *      It breaks current upstream kernel builds and potentially
>> other direct usages of gcc. Kernel is by far the most important use
>> case. Upstream should change the default options to build with
>> -fno-stack-protector by default.
>>    *      It is not conformant to upstream gcc behaviour.
> 
> I don't see why the kernel should have to insert compile flags to 
> counteract any random non-default compile flags that the system may 
> decide to insert. I think the way Ubuntu has done this is broken, they 
> are essentially changing the default settings on the compiler in a way 
> which breaks the kernel due to needing external libraries.
> 

There is a good answer to that question, and that is, the kernel is the 
special case.  It DOES make sense to let the distribution set the 
default to whatever they think the end user should use for applications. 
  The kernel can deal with it easily enough.

	-hpa
