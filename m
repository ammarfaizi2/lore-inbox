Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUEUTci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUEUTci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUEUTci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 15:32:38 -0400
Received: from [213.171.41.46] ([213.171.41.46]:23048 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S265932AbUEUTcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 15:32:36 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Date: Fri, 21 May 2004 23:32:32 +0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <200405200506.03006.alexeyk@mysql.com> <1085016663.2941.10.camel@dyn319009bld.beaverton.ibm.com>
In-Reply-To: <1085016663.2941.10.camel@dyn319009bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200405212332.32522.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 May 2004 05:31, Ram Pai wrote:
>On Wed, 2004-05-19 18:06, Alexey Kopytov wrote:
>> Ram, can you clarify the status of this patch please?
>>
>> I ran the same sysbench test on my hardware with patched 2.6.6 and got
>> 122.2348s execution time, i.e. almost the same results as in the original
>> tests. Is this patch an intermediate step to improve the sysbench workload
>> on 2.6, or it just addresses another problem?
>
>this patch by itself does not address your problem. Your problem is
>better addressed by Andrew's 'readahead-private' patch.
>
>However; this patch applied on top of Andrew's 'readahead-private' patch
>may get you some extra performance.
>
>Can you confirm this please?

Yes.

2.6.6-rc3 + Andrew's patch:

Time spent for test:  86.5459s

2.6.6-bk:

Time spent for test:  83.1929s

Thanks for clarifying!

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
