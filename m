Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbUKXMPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUKXMPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKXMPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:15:46 -0500
Received: from [194.90.79.130] ([194.90.79.130]:49672 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261355AbUKXMPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:15:39 -0500
Message-ID: <41A47B67.6070108@argo.co.il>
Date: Wed, 24 Nov 2004 14:15:35 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain>
In-Reply-To: <1100798975.6018.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2004 12:15:37.0947 (UTC) FILETIME=[4EB43AB0:01C4D21F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I really do believe that user-space filesystems have problems. There's a 
>>reason we tend to do them in kernel space. 
>>
>>But limiting the outstanding writes some way may at least hide the thing.
>>    
>>
>
>Possibly dumb question. Is there a reason we can't have a prctl() that
>flips the PF_* flags for a user space daemon in the same way as we do
>for kernel threads that do I/O processing ?
>
>  
>
http://lkml.org/lkml/2004/7/26/68

discusses a userspace filesystem (implemented as a userspace nfs server 
mounted on a loopback nfs mount), the problem, a solution (exactly your 
suggestion), and a more generic solution.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

