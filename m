Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbSIRLxE>; Wed, 18 Sep 2002 07:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266211AbSIRLxD>; Wed, 18 Sep 2002 07:53:03 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:23222 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S266175AbSIRLxD>; Wed, 18 Sep 2002 07:53:03 -0400
Message-ID: <3D886A17.60509@quark.didntduck.org>
Date: Wed, 18 Sep 2002 07:57:11 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
References: <3D88208E.8545AAA2@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> http://people.redhat.com/drepper/glibcthreads.html says:
> 
> 
>>Hardware restrictions put hard limits on the number of 
>>threads the kernel can support for each process. 
>>Specifically this applies to IA-32 (and AMD x86_64) where the thread
>>register is a segment register. The processor architecture 
>>puts an upper limit on the number of segment register values 
>>which can be used (8192 in this case).
> 
> 
> Is this true?  Where does the limit come from?
> - Dan

A long time ago Linux did use one GDT segment for a TSS and LDT for each 
process.  Then it was changed in 2.3.11 to have one TSS and LDT per cpu, 
removing the limit on the number of processes that can exist in the system.

--
				Brian Gerst


