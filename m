Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSJBWIw>; Wed, 2 Oct 2002 18:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbSJBWIv>; Wed, 2 Oct 2002 18:08:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:36528 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262620AbSJBWIt>;
	Wed, 2 Oct 2002 18:08:49 -0400
Message-ID: <3D9B6F7E.1060004@us.ibm.com>
Date: Wed, 02 Oct 2002 15:13:18 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH]  4KB stack + irq stack for x86
References: <3D9B62AC.30607@us.ibm.com> <20021002174320.J28857@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Wed, Oct 02, 2002 at 02:18:36PM -0700, Dave Hansen wrote:
> 
>>I've resynced Ben's patch against 2.5.40.  However, I'm getting some 
>>strange failures.  The patch is good enough to pass LTP, but 
>>consistently freezes when I run tcpdump on it.
> 
> Try running tcpdump with the stack checking patch applied.  That should 
> give you a decent backtrace for the problem.

My first suspicion was that it was just overflowing, but not getting 
the message out.  I just realized that my latest testing (the last 24 
hours) was on the original patch, not the updated one that you posted 
later, which included the stack checking.  I'm sure that I was having 
the same problem with the overflow checking enabled and _not_ getting 
any errors from it, but I'll redo the testing for my sanity's sake.

-- 
Dave Hansen
haveblue@us.ibm.com

