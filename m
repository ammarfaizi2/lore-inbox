Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTEIEOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 00:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTEIEOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 00:14:32 -0400
Received: from holomorphy.com ([66.224.33.161]:13469 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262289AbTEIEOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 00:14:31 -0400
Date: Thu, 8 May 2003 21:26:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509042659.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB25FD.7060809@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, William Lee Irwin III wrote:
>>>>> Why would you want to use an interrupt? Just count jiffies in sched.c

On Thu, May 08, 2003 at 11:52:29PM -0400, Chris Friesen wrote:
> I'm trying to get a feel for the maximum time from an interrupt coming in 
> until the userspace handler gets notified.  On intel you can program the 
> hardware to generate interupts through /dev/rtc.  The powerpc doesn't seem 
> to support this.
> Jiffies are not accurate enough, I am expecting max latencies in the 1-2 ms 
> range.
> Unfortunately no.  USB/Firewire/Ethernet on the desktop, ethernet/serial 
> for compactPCI.
> I want to find an additional programmable interrupt source.  It bites that 
> cheap PCs have this, and the powerpc doesn't.

Try the timebase instead.


-- wli
