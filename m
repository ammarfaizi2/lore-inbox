Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTEMOIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTEMOIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:08:05 -0400
Received: from watch.techsource.com ([209.208.48.130]:62396 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261256AbTEMOIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:08:04 -0400
Message-ID: <3EC10074.8060806@techsource.com>
Date: Tue, 13 May 2003 10:25:56 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2996.2040908@zytor.com> <3EBC2FD7.2080007@techsource.com> <3EBC389C.2010601@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Timothy Miller wrote:
> 
>>>The purpose is that there is a slight task-switching speed advantage if
>>>the address is in the bottom 4 GB.  Since this affects every process,
>>>and most processes use very little TLS, this is worthwhile.
>>>
>>>This is fundamentally due to a K8 design flaw.
>>
>>Is there an explicit check somewhere for this?  Are the page tables laid
>>out differently?
>>
> 
> 
> No, there are two ways to load the FS base register: use a descriptor,
> which is limited to 4 GB but is faster, or WRMSR, which is slower, but
> unlimited.
> 


Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Timothy Miller wrote:
> 
> 
>>Why does there ever need to be an explicit HINT that you would prefer a
>><32 bit address, when it's known a priori that <32 is better?  Why
>>doesn't the mapping code ALWAYS try to use 32-bit addresses before
>>resorting to 64-bit?
> 
> 
> Because not all memory is addressed via GDT entries.  In fact, almost
> none is, only thread stacks and similar gimicks.  If all mmap memory
> would by default be served from the low memory pool you soon run out of
> it and without any good reason.


All I have to say is... I appreciate your patience with my ignorant 
questions.  :)


