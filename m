Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292306AbSBPBRA>; Fri, 15 Feb 2002 20:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292305AbSBPBQv>; Fri, 15 Feb 2002 20:16:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24283 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292306AbSBPBQf>;
	Fri, 15 Feb 2002 20:16:35 -0500
Date: Fri, 15 Feb 2002 17:17:34 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Paul Menage <pmenage@ensim.com>
cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk 
Message-ID: <13770000.1013822253@w-hlinder.des>
In-Reply-To: <E16bo6h-0003si-00@pmenage-dt.ensim.com>
In-Reply-To: <E16bo6h-0003si-00@pmenage-dt.ensim.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, February 15, 2002 11:33:19 -0800 Paul Menage <pmenage@ensim.com> wrote:

> One obvious problem with it is that __emul_lookup_dentry()[1] calls
> path_walk() internally, and the nd passed has uncounted references and
> no LOOKUP_LOCKED flag - I suspect that this will cause reference counts
> to get mucked up.

Paul,

	Thanks again for your comments. You are right, the d_count is 
getting mucked up through the __emul_lookup_dentry() path. I also 
discovered some problems with the way I was taking the dcache_lock.
So I will go back and try to fix those.
	I saw your patch for path_lookup. The next version of fast walk 
will include those changes (I had started making the changes before seeing
your patch anyway).
	
Hanna 


