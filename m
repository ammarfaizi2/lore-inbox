Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUAKJaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbUAKJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:30:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35589 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265815AbUAKJa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:30:29 -0500
Date: Sun, 11 Jan 2004 10:30:10 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Simon Kirby <sim@netnation.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-ID: <20040111093010.GG545@alpha.home.local>
References: <20040109210450.GA31404@netnation.com> <Pine.LNX.4.58L.0401101719400.1310@logos.cnet> <20040110144049.5e195ebd.akpm@osdl.org> <20040111085506.GA6834@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111085506.GA6834@netnation.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 12:55:06AM -0800, Simon Kirby wrote:
> On Sat, Jan 10, 2004 at 02:40:49PM -0800, Andrew Morton wrote:
> 
> > Presumably it's spinning on the lock with interrupts enabled.  Make that
> > the `NMI' counters in /proc/interrupts are incrementing for all CPUs.
> 
> Actually, on one of the boxes it doesn't seem to be working at all:
> 
> activating NMI Watchdog ... done.
> testing NMI watchdog ... CPU#0: NMI appears to be stuck!  

Could you try with "nmi_watchdog=2" ? This is the only one which works on
my ASUS A7M266-D (MPX + dual XP 1800+).

Willy

