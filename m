Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWIAVBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWIAVBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWIAVBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:01:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35981 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750834AbWIAVBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:01:39 -0400
Message-ID: <44F89FAF.2050601@us.ibm.com>
Date: Fri, 01 Sep 2006 14:01:35 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>	<Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>	<1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com> <20060901101801.7845bca2.akpm@osdl.org>
In-Reply-To: <20060901101801.7845bca2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 01 Sep 2006 09:32:22 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>   
>>>> Kernel BUG at fs/buffer.c:2791
>>>> invalid opcode: 0000 [1] SMP
>>>>
>>>> Its complaining about BUG_ON(!buffer_mapped(bh)).
>>>>         
>
> I need to have a little think about this, remember what _should_ be
> happening in this situation.
>
> We (mainly I) used to do a huge amount of fsx-linux testing on 1k blocksize
> filesystems.  We've done something to make this start happening.  Part of
> resolving this bug will be working out what that was.
>   

Here is the progress in tracking this down so far.

I am able to reproduce the problem on following kernel versions.

2.6.18-rc5
2.6.18-rc4
2.6.17.11
2.6.16.28
2.6.15.7
2.6.14.7

I am yet to find a latest kernel version - where this works :(
I am going to try older versions of the kernel.

Thanks,
Badari


-- 
VGER BF report: H 3.60822e-15
