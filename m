Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161420AbWJSOuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbWJSOuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbWJSOuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:50:35 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:6650 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161420AbWJSOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:50:35 -0400
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mingo@elte.hu,
       tglx@linutronix.de
In-Reply-To: <200610191605.39933.ak@suse.de>
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net>
	 <200610191547.09640.ak@suse.de>
	 <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <200610191605.39933.ak@suse.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 07:50:32 -0700
Message-Id: <1161269432.11264.18.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 16:05 +0200, Andi Kleen wrote:
> > You just mean the if statement above though? I was talking more about
> > the structure above this called "clocksource_pit" which isn't used on
> > SMP systems due to this code addition. AFAIK init_pit_clocksource()
> > could disappear along with the clocksource structure ..
> 
> It will end up as a int f() { return 0; }. Not very much overhead. 
> 
> -Andi

Here's what I found .. 

-rwxr-xr-x  1 dwalker engr 48252535 Oct 19 07:47 vmlinux
-rwxr-xr-x  1 dwalker engr 48249958 Oct 19 07:47 vmlinux.ifdef

So we're talking about ~2.5k of code including the pit_read and
clocksource structure.

Daniel

