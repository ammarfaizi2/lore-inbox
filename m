Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318057AbSGLWpt>; Fri, 12 Jul 2002 18:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318055AbSGLWop>; Fri, 12 Jul 2002 18:44:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14815 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318050AbSGLWo0>;
	Fri, 12 Jul 2002 18:44:26 -0400
Date: Fri, 12 Jul 2002 15:50:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17)
Message-ID: <48480000.1026514224@w-hlinder>
In-Reply-To: <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, July 12, 2002 10:29:53 -0400 Alexander Viro <viro@math.psu.edu> wrote:
> 
> 
> On Fri, 12 Jul 2002, Maneesh Soni wrote:
> 
>> Here is the dcache scalability patch (cleaned up) as disscussed in 
>> the previous post to lkml by Dipankar. The patch uses RCU for doing fast
>> dcache lookup. It also does lazy updates to lru list of dentries to
>> avoid doing write operations while doing lookup.
> 
> Where is
> 	* version for 2.5.<current>
> 	* analysis of benefits in real-world situations for 2.5 version?
> 
> Patch adds complexity and unless you can show that it gives significant
> benefits outside of pathological situations, it's not going in.


Here are the slides where I presented, among other things, some 
performance results of fastwalk compared to using rcu with lazy 
updating of the d_lru list. The results are similar to what Dipankar 
just published but there are a few more data points.

http://lse.sf.net/locking

Thanks.

Hanna


