Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265625AbUFDFxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265625AbUFDFxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUFDFxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:53:41 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:22098 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265625AbUFDFxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:53:40 -0400
Message-ID: <40C00E5E.1090002@yahoo.com.au>
Date: Fri, 04 Jun 2004 15:53:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
References: <20040603094339.03ddfd42.pj@sgi.com>	<20040603101010.4b15734a.pj@sgi.com>	<1086313667.29381.897.camel@bach>	<40BFD839.7060101@yahoo.com.au>	<20040603223005.01bbab21.pj@sgi.com>	<40C00A2B.1040606@yahoo.com.au> <20040603224033.2dc5da9f.akpm@osdl.org>
In-Reply-To: <20040603224033.2dc5da9f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> Yes, I'm all for the full cpumask abstraction.
> 
> 
> Where do we stand wrt pass-by-reference?  I remember there was initially
> some concern that lugging 512-bit scalars around by value was expensive, so
> Bill's original work was at least geared toward pass-by-reference?
> 

That is a valid concern. One I hadn't really thought about
as the patch is coming from SGI :)

kernel/sched.c doesn't pass around cpumask_t's anywhere
critical anymore (this used to be a problem). Any other
important places spring to mind?
