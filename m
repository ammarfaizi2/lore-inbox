Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTEIA0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTEIA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:26:00 -0400
Received: from holomorphy.com ([66.224.33.161]:9884 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262256AbTEIAZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:25:59 -0400
Date: Thu, 8 May 2003 17:38:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509003825.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 06:12:12PM -0400, Chris Friesen wrote:
>>> I'm trying to test the scheduler latency on a powerpc platform.  It appears
>>> that a realfeel type of program won't work since you can't program /dev/rtc
>>> to generated interrupts on powerpc.  Is there anything similar which could
>>> be done?

On Thu, 8 May 2003, William Lee Irwin III wrote:
> > Why would you want to use an interrupt? Just count jiffies in sched.c

On Thu, May 08, 2003 at 05:38:23PM -0700, Davide Libenzi wrote:
> I don't know what he does mean for scheduler latency, but if it is the ctx
> switch one something like get_cycles() will be better instead of jiffies.

True, if you're looking for performance tweaks and not pathologies (which
I was) you'll need something that accurate.


-- wli
