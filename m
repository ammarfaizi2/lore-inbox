Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWFVPhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWFVPhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWFVPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:37:32 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33750 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751153AbWFVPhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:37:31 -0400
Message-ID: <449AB908.30002@zytor.com>
Date: Thu, 22 Jun 2006 08:36:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for  `cmp'
 [was Re: 2.6.1
References: <200606220238_MC3-1-C321-1AC2@compuserve.com>
In-Reply-To: <200606220238_MC3-1-C321-1AC2@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>>>>
>>> It's complaining about this:
>>>
>>> #APP
>>>         addl %ecx,%eax ; sbbl %edx,%edx; cmpl %eax,$-1073741824; sbbl $0,%edx   # dump.u_dsize, sum, flag,
>>> #NO_APP
>> The cmpl should have its arguments reversed.  It's quite possible some versions of the 
>> assembler accepts the form given, but they're wrong (and doubly confusing when used as 
>> input to sbb.)
> 
> This was built with gcc 4.0.4 20060507 (prerelease).
> 
> I don't normally build a.out support, but I just tried and it compiled
> fine with gcc 4.1.1.  SO this is probably a compiler bug (almost certainly
> given that it generated illegal assembler code.)
> 

It's not (it's #APP, i.e. inline assembly); rather, it's an illegal 
constraint.

	-hpa
