Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUFVWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUFVWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUFVV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:57:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:18091 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265761AbUFVVze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:55:34 -0400
Subject: Re: [PATCH] ppc32: Support for new Apple laptop models
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200406221745.31553.jbarnes@engr.sgi.com>
References: <1087934829.1832.3.camel@gaston>
	 <200406221745.31553.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1087940927.1854.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 16:48:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 16:45, Jesse Barnes wrote:
> On Tuesday, June 22, 2004 4:07 pm, Benjamin Herrenschmidt wrote:
> > This patch adds support for newer Apple laptop models. It adds the basic
> > identification for the new motherboards and the cpufreq support for models
> > using the new 7447A CPU from Motorola.
> 
> And here's a patch to add sound support for some of the newer PowerBooks.  It 
> appears that this chip supports the AWACS sample rates, but has a 
> snapper-style mixer.  Tested and works on my PowerBook5,4.
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Can you check out in more details the OS X driver ? I think there
need to be some i2s tweaking when changing the format and/or the
frequency. Doing that right would allow to support 8 & 16 bits
properly at least. 

Also, don't leave the commented out line, especially with  the c++
style comments. If the chip can byteswap, make sure you have proper
code to do this, if not, leave can_byteswap to 0, or people will
experience all sorts of funny troubles ;)

Ben.


