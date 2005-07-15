Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263243AbVGOIpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbVGOIpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbVGOIpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:45:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2831 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263243AbVGOIo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:44:59 -0400
Date: Fri, 15 Jul 2005 09:44:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715094445.D25428@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
	dtor_core@ameritech.net, vojtech@suse.cz,
	david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
	azarah@nosferatu.za.org, christoph@lameter.com
References: <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>; from torvalds@osdl.org on Thu, Jul 14, 2005 at 05:24:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 05:24:39PM -0700, Linus Torvalds wrote:
> HOWEVER. I bet that somebody who really really cares (hint hint) could
> easily make HZ be 1000, and then dynamically tweak the divisor at bootup
> to be either 1000, 250, or 100, and then increment "jiffies" by 1, 4 or
> 10.

Wouldn't this be better suited to a VST like implementation, but
instead of using VST to dynamically adjust the timer divisor, it
operates in a "fixed" mode?

(I'm arguing this way because ARM has VST merged already, and all
there are no changes required to the core kernel code to achieve
this.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
