Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVAZBBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVAZBBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVAYXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262232AbVAYXSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:18:03 -0500
Date: Tue, 25 Jan 2005 15:17:57 -0800
Message-Id: <200501252317.j0PNHvE5014057@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
In-Reply-To: Christoph Lameter's message of  Tuesday, 25 January 2005 14:52:56 -0800 <Pine.LNX.4.58.0501251450080.26368@schroedinger.engr.sgi.com>
X-Windows: never had it, never will.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your patch breaks the mmtimer driver because it used k_itimer values for
> its own purposes. Here is a fix by defining an additional structure
> in k_itimer (same approach for mmtimer as the cpu timers):

This seems reasonable enough to me.  Perhaps if there will be lots of timer
guts implementations, and more coming in modules or whatnot, then the union
should be replaced with a more generic private-data buffer, or at least
have a vanilla padding alternative in the union.  But I am certainly happy
with the simple path of just adding in the implementations as they come
like you've done for mmtimer.


Thanks,
Roland
