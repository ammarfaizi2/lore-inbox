Return-Path: <linux-kernel-owner+w=401wt.eu-S964825AbWLMAcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWLMAcd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWLMAcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:32:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:29402 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964825AbWLMAca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:32:30 -0500
Date: Tue, 12 Dec 2006 17:31:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Support 2.4 modules features in 2.6
In-reply-to: <fa.eHbXg8xrK/U8MrbcE6JMfwHCb1k@ifi.uio.no>
To: Jaswinder Singh <jaswinderrajput@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Message-id: <457F3BBC.6020301@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.49G5lweS8py4hisexsfl1zRqB3Y@ifi.uio.no>
 <fa.o58YYFf0KmJCYaGfzWFQYvWvWqw@ifi.uio.no>
 <fa.LL4m3y1d6ywMNgGlDl6zW5gCaRA@ifi.uio.no>
 <fa.uN/dXUaQFfxu97P18c1QPZodm1A@ifi.uio.no>
 <fa.eHbXg8xrK/U8MrbcE6JMfwHCb1k@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
>> you only need include/* for this in 2.6
>>
>> you can't do this at all with 2.4 kernels, it needs the whole lot.
>>
>> (in both cases the code and headers are needed so that your module can
>> use the data structures and compile in the kernel code you select to use
>> from inlines)
>> >
>> >
> 
> Really!!
> 
> This is my Makefile :-
> obj-m += hello-1.o
> 
> all:
>     make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> 
> clean:
>     make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
> 
> 
> Now do one thing:-
> # mv /lib/modules/$(uname -r)/build /lib/modules/$(uname -r)/build0
> 
> now make it.

Of course you can't, there are no kernel header files left.

> 
> If you want point to your header files in /usr/include and then try to 
> build.

Those are userspace header files, not for building modules. They may 
have worked in certain setups for doing this in the past but this was 
never recommended. Current distributions no longer include any 
kernel-internal headers in /usr/include anymore.

You do need at least a partial kernel source tree to build modules against.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

