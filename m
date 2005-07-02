Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263359AbVGBCLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbVGBCLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVGBCJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:09:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:741 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263451AbVGBCCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 22:02:08 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Lee Revell <rlrevell@joe-job.com>
To: William Weston <weston@sysex.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
	 <200506301952.22022.annabellesgarden@yahoo.de>
	 <20050630205029.GB1824@elte.hu>
	 <200507010027.33079.annabellesgarden@yahoo.de>
	 <20050701071850.GA18926@elte.hu>
	 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 22:02:02 -0400
Message-Id: <1120269723.12256.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 18:46 -0700, William Weston wrote:
> FWIW, I'm still seeing the SMT scheduling? meltdown issues with
> -50-42.  
> Running two instances of 'dd if=/dev/zero of=/dev/null bs=65536'
> instead 
> of 'burnP6' results in the same behavior.  Here's a quick recap:
> 
> - Start (or login to ) X.
> - Start an X app that constantly updates the screen, like wmcube, or
> vlc. 

Which video driver is X using?  What nice value is the X server running
at?

Does adding:

Option "NoAccel"

to the Device section of your X config file make any difference?

(on most systems X is the only thing besides the kernel that can access
hardware directly, which can cause problems)

Lee

