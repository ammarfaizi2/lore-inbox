Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271584AbTGQWbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271601AbTGQWaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:30:03 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:49393 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S271612AbTGQW26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:28:58 -0400
Date: Thu, 17 Jul 2003 15:43:08 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717224307.GF19891@ca-server1.us.oracle.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
	linux-kernel@vger.kernel.org
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org> <20030718002451.A2569@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718002451.A2569@pclin040.win.tue.nl>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:24:51AM +0200, Andries Brouwer wrote:
> Premise: some filesystems or archives store 32 bits.
> Conclusion: we must be able to handle that.
> This is unrelated to the kernel, unrelated to system calls,
> it is related to <sys/sysmacros.h>.

	How does linux handle that today?  IIRC, it ignores the high
16bits and treats that 32bit number as 8:8.  That is what happens today,
for every filesystem, whether it stores 32 or 16 bits.
	Why expand that?  We can continue to treat 32bit numbers (eg,
from NFSv2) as 16bit numbers.

Joel


-- 

"One of the symptoms of an approaching nervous breakdown is the
 belief that one's work is terribly important."
         - Bertrand Russell 

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
