Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVDHHGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVDHHGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVDHHGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:06:30 -0400
Received: from z-iris2a.zipa.com ([204.251.14.252]:19384 "HELO
	z-iris2.zipa.com") by vger.kernel.org with SMTP id S262716AbVDHHF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:05:56 -0400
X-Iris-Host: 3274119041/[195.39.23.129]
Message-ID: <42562D47.9080705@dawes.za.net>
Date: Fri, 08 Apr 2005 09:05:43 +0200
From: Rogan Dawes <rogan@dawes.za.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408050458.GB8720@taniwha.stupidest.org> <d353vk$72m$1@terminus.zytor.com>
In-Reply-To: <d353vk$72m$1@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <20050408050458.GB8720@taniwha.stupidest.org>
> By author:    Chris Wedgwood <cw@f00f.org>
> In newsgroup: linux.dev.kernel
> 
>>On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
>>
>>
>>>Yes. The silly thing is, at least in my local tests it doesn't
>>>actually seem to be _doing_ anything while it's slow (there are no
>>>system calls except for a few memory allocations and
>>>de-allocations). It seems to have some exponential function on the
>>>number of pathnames involved etc.
>>
>>I see lots of brk calls changing the heap size, up, down, up, down,
>>over and over.
>>
>>This smells a bit like c++ new/delete behavior to me.
>>
> 
> 
> Hmmm... can glibc be clued in to do some hysteresis on the memory
> allocation?
> 
> 	-hpa

Take a look at 
http://www.linuxshowcase.org/2001/full_papers/ezolt/ezolt_html/

Abstract

GNU libc's default setting for malloc can cause a significant 
performance penalty for applications that use it extensively, such as 
Compaq's high performance extended math library, CXML.  The default 
malloc tuning can cause a significant number of minor page faults, and 
result in application performance of only half of the true potential. 
This paper describes how to remove the performance penalty using 
environmental variables and the method used to discover the cause of the 
malloc performance penalty.

Regards,

Rogan
