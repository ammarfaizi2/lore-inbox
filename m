Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSGLO1U>; Fri, 12 Jul 2002 10:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGLO1T>; Fri, 12 Jul 2002 10:27:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62954 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316544AbSGLO1O>;
	Fri, 12 Jul 2002 10:27:14 -0400
Date: Fri, 12 Jul 2002 10:29:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Maneesh Soni <maneesh@in.ibm.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [RFC] dcache scalability patch (2.4.17)
In-Reply-To: <20020712193935.B13618@in.ibm.com>
Message-ID: <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Maneesh Soni wrote:

> Here is the dcache scalability patch (cleaned up) as disscussed in 
> the previous post to lkml by Dipankar. The patch uses RCU for doing fast
> dcache lookup. It also does lazy updates to lru list of dentries to
> avoid doing write operations while doing lookup.

Where is
	* version for 2.5.<current>
	* analysis of benefits in real-world situations for 2.5 version?

Patch adds complexity and unless you can show that it gives significant
benefits outside of pathological situations, it's not going in.

Note: measurements on 2.4 do not make sense; reduction of cacheline
bouncing between 2.4 and 2.5 will change the results anyway and
if any of these patches are going to be applied to 2.4, reduction of
cacheline bouncing on ->d_count is going to go in before that one.

