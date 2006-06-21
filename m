Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWFUWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWFUWTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWFUWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:19:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42427 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030339AbWFUWTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:19:03 -0400
Message-ID: <4499C5DB.9010001@engr.sgi.com>
Date: Wed, 21 Jun 2006 15:19:07 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<20060621133838.12dfa9f8.akpm@osdl.org>	<4499BAA9.3000707@watson.ibm.com>	<4499BDDD.3010206@engr.sgi.com> <20060621145443.b58daf31.akpm@osdl.org>
In-Reply-To: <20060621145443.b58daf31.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>On Wed, 21 Jun 2006 14:45:01 -0700
>Jay Lan <jlan@engr.sgi.com> wrote:
>
>  
>>>Won't it suffice to make delivery of these stats best effort, with
>>>userspace dealing with missing data,
>>>      
>>How do you recover the missed data?
>>    
>
>I suspect the best we can do is to let userspace know that data was lost. 
>Is the -ENOBUFS reliable?
>  

We need to reduce that to an acceptable rate. In the real life, the rate
should be
must less. Under this test, i have one drop every < 5 minutes. I will
talk to
our deamon expert to see how we can improve it... and get a better define of
"acceptable rate".

- jay

>  
>>>rather than risk delaying exits ? The cases where exits are so
>>>frequent as in this program should be
>>>      
>>This is very true. However, it was a 2p IA64 machine. I am too frightened to
>>speak "512p"...
>>    
>
>If we have 511 CPUs generating data faster than one CPU can handle it,
>something bad will happen.  We either throttle the 511 CPUs or drop data.
>
>  

