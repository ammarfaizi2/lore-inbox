Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264816AbUEEWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264816AbUEEWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264817AbUEEWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:04:58 -0400
Received: from [213.171.41.46] ([213.171.41.46]:2310 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S264816AbUEEWEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:04:55 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Random file I/O regressions in 2.6
Date: Thu, 6 May 2004 02:04:51 +0400
User-Agent: KMail/1.6.2
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <200405050301.32355.alexeyk@mysql.com> <20040504162037.6deccda4.akpm@osdl.org>
In-Reply-To: <20040504162037.6deccda4.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405060204.51591.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Alexey Kopytov <alexeyk@mysql.com> wrote:
>> With the patch:
>> ---------------
>> Time spent for test:  86.5459s
>>
>> no of times window reset because of hits: 0
>> no of times window reset because of misses: 0
>> no of times window was shrunk because of hits: 1066
>> no of times the page request was non-contiguous: 5860
>> no of times the page request was contiguous : 18099
>
>The patch brought my test box to the same speed as 2.4.  With the deadline
>scheduler it was a bit faster than 2.4.  I didn't do a lot of testing
>though.  I was using ext2.  Please try deadline.
>

Results with the deadline scheduler on my hardware:

Time spent for test:  92.8340s

no of times window reset because of hits: 0
no of times window reset because of misses: 0
no of times window was shrunk because of hits: 1108
no of times the page request was non-contiguous: 5860
no of times the page request was contiguous : 18091

I have updated the results on the SysBench home page with 2.6.6-rc3 with the 
patch applied.

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
