Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263656AbREYIkj>; Fri, 25 May 2001 04:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263657AbREYIkb>; Fri, 25 May 2001 04:40:31 -0400
Received: from ns.suse.de ([213.95.15.193]:4100 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263656AbREYIkX>;
	Fri, 25 May 2001 04:40:23 -0400
Date: Fri, 25 May 2001 10:39:21 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525103921.A26630@gruyere.muc.suse.de>
In-Reply-To: <20010525102015.C26038@gruyere.muc.suse.de> <26599.990779480@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <26599.990779480@ocs3.ocs-net>; from kaos@ocs.com.au on Fri, May 25, 2001 at 06:31:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 06:31:20PM +1000, Keith Owens wrote:
> That is exactly what I said above, a separate fault task with its own
> stack for every cpu.  But there is no point in doing this to detect a
> hardware stack overflow when the overflow has already corrupted the
> struct task which is at the bottom of the stack segment.

You can at least get a backtrace, which is useful enough.

> 
> To get any benefit from hardware detection of kernel stack overflow you
> must also dedicate the stack segment to hold only stack data.  That
> means moving struct task to yet another page, adding an extra page per
> task.  It is just too expensive, we write better code than that.

Ah this was a misunderstanding. I was just talking about plain recovery
from stack faults; not from hardware stack overflow detection. Even without
wather tight overflow detection they happen often enough and usually not
too long after a stack page overflow.




-Andi
