Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbTC1WQk>; Fri, 28 Mar 2003 17:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbTC1WQk>; Fri, 28 Mar 2003 17:16:40 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:6644 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S263170AbTC1WQj>; Fri, 28 Mar 2003 17:16:39 -0500
Date: Fri, 28 Mar 2003 14:25:25 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NICs trading places ?
Message-ID: <20030328222524.GK32000@ca-server1.us.oracle.com>
References: <20030328221037.GB25846@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328221037.GB25846@suse.de>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 10:10:37PM +0000, Dave Jones wrote:
> I just upgraded a box with 2 NICs in it to 2.5.66, and found
> that what was eth0 in 2.4 is now eth1, and vice versa.
> Is this phenomenon intentional ? documented ?
> What caused it to do this ?

	Is this a Red Hat system?  I encountered the same thing on a
RHAS system.  Basically, Anaconda had controlled the module load order
in /etc/modules.conf for 2.4.  Because my network drivers were built in
in 2.5, they loaded in the order of the compile-in.  This turned out to
be the reverse order.
	Swapping eth0 and eth1 in /etc/modules.conf fixed the problem
for me.  This is not to say it is "Red Hat's fault" or that this is
entirely the same situation, but I figured this would make a good
datapoint.

Joel

-- 

"It is not the function of our government to keep the citizen from
 falling into error; it is the function of the citizen to keep the
 government from falling into error."
	- Robert H. Jackson

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
