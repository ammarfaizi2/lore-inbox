Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUHENXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUHENXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUHENXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:23:14 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4599 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267205AbUHENXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:23:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
	<20040804232123.3906dab6.akpm@osdl.org> <4111DC8C.7050504@redhat.com>
	<20040805001737.78afb0d6.akpm@osdl.org> <4111E3B5.1070608@redhat.com>
	<1091704539.5031.42.camel@bach>
From: Linh Dang <linhd@nortelnetworks.com>
Organization: Null
Date: Thu, 05 Aug 2004 09:23:06 -0400
In-Reply-To: <1091704539.5031.42.camel@bach> (Rusty Russell's message of
 "Thu, 05 Aug 2004 21:48:05 +1000")
Message-ID: <wn5llgtyb0l.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:

> I don't think this is neccessarily true: I think that platforms with
> 64-bit compare-and-exchange can do the whole thing in userspace.
> They would set the mutex and stamp in the thread ID simultanously,
> allowing for "dead thread" detection (ie. I didn't get the lock, and
> it's a robust mutex: check the holder is still alive).

Or for priority-inheritance: try get the lock, if failed raised the
holder's priority to mine if necessary.

>
> W/o 64-bit compare-and-exchange a 100% robust solution may not be
> possible though.

PPC arch can do a lot of things in a pseudo-atomic way.

>
> Thoughts?
> Rusty.

-- 
Linh Dang
