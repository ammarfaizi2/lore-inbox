Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbUKEBdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbUKEBdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUKEBcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:32:19 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:25277 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262529AbUKEBb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:31:29 -0500
Message-ID: <418AD7EC.8020300@yahoo.com.au>
Date: Fri, 05 Nov 2004 12:31:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, pj@sgi.com, colpatch@us.ibm.com
Subject: Re: cache_hot_time
References: <20041104210425.GC1268@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20041104210425.GC1268@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> Hi,
> 
> Im catching up on all the scheduler changes, and I noticed some large
> changes in cache_hot_time. All but ia64 seem to have shifted by 1000. Is
> this intententional?
> 

Don't think so. They should be all in units of sched_clock()
(ie. ns), so 10ms and 2.5ms are surely the intended values here.

> Anton
> 
> include/linux/topology.h:       .cache_hot_time         = (5*1000/2),       
> include/asm-i386/topology.h:    .cache_hot_time         = (10*1000),
> include/asm-ppc64/topology.h:   .cache_hot_time         = (10*1000),
> include/asm-x86_64/topology.h:  .cache_hot_time         = (10*1000),
> include/asm-ia64/topology.h:    .cache_hot_time         = (10*1000000),
> include/asm-ia64/topology.h:    .cache_hot_time         = (10*1000000),
> 

