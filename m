Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUCWVhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUCWVhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:37:37 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:13094 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262837AbUCWVhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:37:36 -0500
Date: Tue, 23 Mar 2004 13:36:50 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-Id: <20040323133650.2044fd8f.pj@sgi.com>
In-Reply-To: <20040323101323.GD2045@holomorphy.com>
References: <1079651082.8149.175.camel@arrakis>
	<20040322230850.1d8f26dc.pj@sgi.com>
	<20040323101323.GD2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes - making the *_complement ops into two operand (dst, src) would be a
good idea, Bill.  Thanks.  I will likely include that in what I'm doing
now.

Meanwhile, Matthew's patch 5/7 appears broken here.

My current understanding of the complement op is that it is broken for
non-word multiple sizes.  There's a good chance I'm still be confused on
this matter.

It might make sense to redo this particular bit of offline logic not by
using *_complement, but rather by looping over all nodes, and only
acting if not online, thus avoiding the *_complement() operator for now.
I have not thought through the performance implications of such a code
inversion, however.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
