Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWE1APp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWE1APp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 20:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWE1APp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 20:15:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12432 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965000AbWE1APo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 20:15:44 -0400
Message-ID: <4478EBAD.4060105@us.ibm.com>
Date: Sat, 27 May 2006 17:15:41 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: Andrew Morton <akpm@osdl.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu,
       Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and	use	aio_read/aio_write instead
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>	 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>	 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>	 <20060521180037.3c8f2847.akpm@osdl.org>	 <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>	 <20060522100640.0710f7da.akpm@osdl.org>	 <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>	 <4472C7E1.3060004@themaw.net> <1148394915.8788.4.camel@raven.themaw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kent wrote:

>On Tue, 2006-05-23 at 16:29 +0800, Ian Kent wrote:
>
>>Badari Pulavarty wrote:
>>
>>>On Mon, 2006-05-22 at 10:06 -0700, Andrew Morton wrote:
>>>
>>>>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>>>
>>>>>On Sun, 2006-05-21 at 18:00 -0700, Andrew Morton wrote:
>>>>>
>>>>>>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>>>>>
>>>>>>>This patch removes readv() and writev() methods and replaces
>>>>>>> them with aio_read()/aio_write() methods.
>>>>>>>
>>>>>>And it breaks autofs4
>>>>>>
>>>>>>autofs: pipe file descriptor does not contain proper ops
>>>>>>
>>>>>Any easy test case to reproduce the problem ?
>>>>>
>>>>Grab an FC5 setup, copy RH's .config into your tree.
>>>>
>>>Will do. 
>>>
>>>Like I mentioned, I am travelling this week. I would really
>>>appreciate if someone could test my updated patch (I sent out
>>>in my earlier mail).
>>>
>>Doesn't seem to apply to 2.6.17-rc4.
>>
>>[raven@raven linux-2.6.16]$ patch -p1 < 
>>~/remove-readv_writev-methods-and-use-aio_read_aio_write.patch
>>patching file drivers/char/raw.c
>>

This patch is the 2nd patch in the series. So you need to apply 
vectorize-aio methods
patch first. Anyway, I am going to re-test and send out the series when 
I get back.

Thanks,
Badari

>



