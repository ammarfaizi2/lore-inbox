Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUCDSuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUCDSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:50:00 -0500
Received: from terminus.zytor.com ([63.209.29.3]:32962 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262070AbUCDSt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:49:58 -0500
Message-ID: <40477A41.1080409@zytor.com>
Date: Thu, 04 Mar 2004 10:49:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       Chris Friesen <cfriesen@nortelnetworks.com>, linuxabi@zytor.com,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [Linuxabi] Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>	<200402292130.55743.mmazur@kernel.pl>	<c1tk26$c1o$1@terminus.zytor.com>	<200402292221.41977.mmazur@kernel.pl>	<yw1xn0711sgw.fsf@kth.se>	<40434BD7.9060301@nortelnetworks.com>	<m37jy4cuaw.fsf@defiant.pm.waw.pl>	<20040303152213.GA2148@mars.ravnborg.org>	<m3u115zxif.fsf@defiant.pm.waw.pl> <40475E5C.9020708@pobox.com>
In-Reply-To: <40475E5C.9020708@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Krzysztof Halasa wrote:
> 
>> Sam Ravnborg <sam@ravnborg.org> writes:
>>
>>
>>> IIRC the current agreed scheme is something along the lines of this:
>>>
>>> abi/abi-linux/* Userspace relevant parts of include/linux
>>> abi/abi-asm/ symlink to abi/abi-$(ARCH)
>>> abi/abi-i386 i386 specific userland abi
>>> abi/abi-ppc  ppc ....
>>
>>
>>
>> More efforts, no real effects.
>> I don't think we need such an infrastructure.
>> The normal headers should just be usable for user-space inclusion.
> 
> 
> No, this is a big pain :)
> 
> The ABI headers shared with userspace need to be split from definitions 
> that are only used in kernel space.  #ifdef __KERNEL__ is a source of 
> frustration :)
> 

The biggest problem is that what is kernel ABI hasn't been very well 
thought about.  The result is that the split between the what the kernel 
exports and what libc is supposed to provide itself is very haphazard.

And yes, #ifdef __KERNEL__ is a reflection of that.

	-hpa
