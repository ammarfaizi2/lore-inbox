Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVEFMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVEFMSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVEFMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:18:13 -0400
Received: from ns.itc.it ([217.77.80.3]:54252 "EHLO mail.itc.it")
	by vger.kernel.org with ESMTP id S261181AbVEFMSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:18:05 -0400
Date: Fri, 6 May 2005 14:20:40 +0200
From: Fabio Brugnara <brugnara@itc.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Fabio Brugnara <brugnara@itc.it>, linux-kernel@vger.kernel.org
Subject: Re: problem with mmap over nfs
Message-ID: <20050506122040.GT9742@maestoso.itc.it>
References: <20050506095023.GS9742@maestoso.itc.it> <20050506045446.1deba35d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506045446.1deba35d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please generate a kernel profile?
> 
> - Compile with CONFIG_PROFILING
> 
> - Start the workload, wait for steady state.
> 
> - As root, run:
> 
> #!/bin/sh
> 
> SM=/boot/System.map
> TIMEFILE=/tmp/prof.time
> readprofile -r
> sleep 10
> readprofile -n -v -m $SM | sort -n +2 | tail -40 | tee $TIMEFILE >&2
> 
> (make sure that /boot/System.map is from the currently-running kernel)
> 
> More in Documentation/basic_profiling.txt
> 
> 
> 
> Even better, learn to drive oprofile.  Once it's running properly I usually
> use this silly script:
> 
> #!/bin/sh
> opcontrol --stop
> opcontrol --shutdown
> rm -rf /var/lib/oprofile
> opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> opcontrol --start-daemon
> opcontrol --start
> sleep 10
> opcontrol --stop
> opcontrol --shutdown
> opreport -l /boot/vmlinux-$(uname -r) | head -50


Wow! Thank you, Andrew.
If we have to consider me alone, this sounds like a dentist
that says "please extract your bad teeth and send it for the fix".
But I hope I'm able to do it with the help of our system administrators.

best regards,
thank you again for your attention,
Fabio

