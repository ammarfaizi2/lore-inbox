Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266698AbUGVQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUGVQHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266701AbUGVQHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:07:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:46232 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266698AbUGVQHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:07:35 -0400
Message-ID: <40FFD64B.8040304@kegel.com>
Date: Thu, 22 Jul 2004 07:59:23 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
CC: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       crossgcc <crossgcc@sources.redhat.com>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       "'Andrew Morton'" <akpm@osdl.org>, "'bert hubert'" <ahu@ds9a.nl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: case-sensitive file names during build
References: <313680C9A886D511A06000204840E1CF08F43052@whq-msgusr-02.pit.comms.marconi.com> <0C006758-DBEE-11D8-9AB1-000A95A0560C@us.ibm.com>
In-Reply-To: <0C006758-DBEE-11D8-9AB1-000A95A0560C@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> On Jul 22, 2004, at 4:25 AM, Povolotsky, Alexander wrote:
>>> make[3]: *** No rule to make target
>>>  `net/ipv4/netfilter/ipt_ecn.o', needed by 
>>> `net/ipv4/netfilter/built-in.o'.
>>> Stop.
>>
>> This is the (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in the
>> linux kernel. Windows filesystems are case insensitive, and see this 
>> as one file.
> 
> I had not seen the ECN/ecn problem, but you will also be bitten by .S -> 
> .s preprocessing. That's right about the point that I gave up  ...

I maintain patches that allow building glibc on Cygwin and MacOSX.
The main patch deals with exactly this issue (S vs. s)
http://kegel.com/crosstool/crosstool-0.28-rc26/patches/glibc-2.3.2/glibc-2.3.2-cygwin.patch
I have to maintain it separately as the glibc maintainer dislikes the
idea of catering to Cygwin users (though maybe if I present it
as a MacOSX support patch he'd reconsider... naaah, probably not :-).

With the advent of linux-2.6, I also have a patch
to get kconfig to not use shared libraries (since I use kconfig
to help install the kernel headers, and shared libraries are tricky
to build on those two platforms).

It wouldn't be a big leap for me or someone else to also maintain
a patch to allow compiling the whole kernel on Cygwin or MacOSX.
If anyone puts it together, I'll carry it in crosstool.
- Dan


-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
