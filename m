Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJMQgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJMQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:36:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:20205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261920AbTJMQgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:36:25 -0400
Date: Mon, 13 Oct 2003 09:36:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
In-Reply-To: <20031013040219.6ad71a57.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0310130934360.21879-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Oct 2003, Andrew Morton wrote:
> 
> Sigh.  Using signals to communicate with kernel threads is evil.  It keeps
> on breaking and each site does it differently and we've had plenty of bugs
> due to this practice.

Yeah, it's not wonderfully pretty, but at least this patch makes bugs 
_less_ likely, by having more of the common stuff abstracted out. And 
clearly allow_signal() was broken before, since it didn't allow anything 
but deadly signals, despite the fact that it was supposed to be generic.

		Linus

