Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTEIAYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTEIAYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:24:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:33194 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262253AbTEIAYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:24:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 8 May 2003 17:38:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't
 work due to /dev/rtc issues
In-Reply-To: <20030509001339.GQ8978@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, William Lee Irwin III wrote:

> On Thu, May 08, 2003 at 06:12:12PM -0400, Chris Friesen wrote:
> > I'm trying to test the scheduler latency on a powerpc platform.  It appears
> > that a realfeel type of program won't work since you can't program /dev/rtc
> > to generated interrupts on powerpc.  Is there anything similar which could
> > be done?
>
> Why would you want to use an interrupt? Just count jiffies in sched.c

I don't know what he does mean for scheduler latency, but if it is the ctx
switch one something like get_cycles() will be better instead of jiffies.



- Davide

