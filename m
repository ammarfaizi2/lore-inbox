Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLZTYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLZTYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVLZTYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:24:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36063 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932122AbVLZTYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:24:10 -0500
Date: Mon, 26 Dec 2005 14:24:06 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/11] mutex subsystem, -V7
In-reply-to: <20051223161649.GA26830@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512261315570.14654@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

Coming next are 3 patches to your mutex code that I'd like you to 
consider.  They express my last requests about mutexes.

The first patch is a resent of my trylock rework to allow for a pure 
xchg based implementation.

The second one gives architectures the ability to make lock/unlock 
fastpaths inlined.  As explained in another mail this is almost always 
beneficial on ARM.

And the last patch makes mutex_is_locked() always inlined since I can't 
find a reason why it wouldn't be beneficial to do so, even on x86.

I hope we can agree on them so that I could go back hiding behind 
ARM-specific part of the kernel again.  :-)


Nicolas
