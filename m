Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbTCKTjg>; Tue, 11 Mar 2003 14:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCKTjg>; Tue, 11 Mar 2003 14:39:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55186 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261537AbTCKTjf>; Tue, 11 Mar 2003 14:39:35 -0500
Date: Tue, 11 Mar 2003 11:39:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>,
       linux-kernel@vger.kernel.org
cc: "Kevin P. Fleming" <kpfleming@cox.net>
Subject: RE: OOPS in do_try_to_free_pages with VERY large software RAID array
Message-ID: <25390000.1047411570@flay>
In-Reply-To: <8075D5C3061B9441944E137377645118012E97@cinshrexc03.shermfin.com>
References: <8075D5C3061B9441944E137377645118012E97@cinshrexc03.shermfin.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the help Martin.  It looks like that was the problem.  The
> kernel mdstat statistics must have been overwriting some other kernel
> memory and giving me my panics.  With the help of Kevin's 2.5 patch I
> patched the Red Hat 2.4.18-26 md code to use seq_file and now my big
> RAID arrays are syncing and I haven't had a panic yet :D
> 
> Thanks again to everyone for the help.  I'll submit the patch to the
> linux-raid list as md-seq_file-2.4.18-26.7.x.patch if anyone's
> interested.

Cool. If I get bored at some point, I might try to make a debug option
to put some minefield trap after /proc functions to catch them doing
this. Or we change the interface ;-)

I got burnt by the same thing for being the first twit to try booting
a 16 CPU ia32 machine ... /proc/cpuinfo went a bit wild.

M.

