Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTK0UPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTK0UPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:15:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:59800 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261152AbTK0UPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:15:16 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 27 Nov 2003 12:15:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: David Hinds <dhinds@sonic.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031127105612.B28106@sonic.net>
Message-ID: <Pine.LNX.4.44.0311271213040.2011-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, David Hinds wrote:

> On Mon, Nov 24, 2003 at 07:08:26PM -0800, Davide Libenzi wrote:
> > 
> > I didn't want to post this because I was ashamed of the fix, but w/out 
> > this my orinoco cardbus gets an interrupt one every ten boots. This is 
> > against 2.4.20 ...
> > 
> > - Davide
> 
> Your patch seems to do two things:
> 
> First, it automatically falls back on using a socket's PCI interrupt
> if its ISA interrupts are not available.  That part seems ok.
> 
> But, it also falls back on sharing an interrupt if a driver requested
> an exclusive interrupt and that was not available.  This part is not
> ok.  The original code will share a PCI interrupt automatically, but
> will not share an ISA interrupt except under certain circumstances
> (for multifunction cards or when the driver specifically requests it).
> Sharing ISA interrupts is unsafe and should never be done blindly.

I told you it was bogus :) Seriously, I don't even know if the "bogus path"
is ever taken, I believe not. I did a quick fix at the beginning and I 
did not look at it anymore. I'll give it a shot ...



- Davide


