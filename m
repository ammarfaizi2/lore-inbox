Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUC3Ari (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUC3Arh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:47:37 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:4311 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262966AbUC3Arg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:47:36 -0500
Date: Mon, 29 Mar 2004 15:50:55 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040329155055.4c032a5e.pj@sgi.com>
In-Reply-To: <20040329235233.GV791@holomorphy.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, not those two. xor of 0's is 0 again. and of 0 and anything is 0 again.

I agree with Bill on this.


> It looks like Paul wants those invariants.

No - bitmap wants these invariants, and I wanted bitmap to be
consistent.  It's an exposed API in its own right.  Since it mostly
already had filtering of unused bits on Boolean/scalar ops, and
avoidance of setting unused bits on proper calls, I completed that
model.

For masks, I promise not to set them if you don't screw up, but I don't
add any code to protect against such, and I don't hestitate to presume
the unused bits are always zero whenever it is convenient to do so.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
