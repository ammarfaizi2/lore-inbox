Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUJKEIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUJKEIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbUJKEIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:08:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:29126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268680AbUJKEIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:08:50 -0400
Date: Sun, 10 Oct 2004 21:08:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <1097466354.3539.14.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410102104530.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>  <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <1097466354.3539.14.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> Disagreed. Sorry, but can you give me a good example ? The drivers still
> do the broken assumptions of passing directly the state parameter to
> pci_set_power_state() (or whatever we call this one these days) but this
> is worked around by defining PM_SUSPEND_MEM to 3 in pm.h.

.. take a look at PM_SUSPEND_DISK for a moment.

If you only care about PM_SUSPEND_MEM, then what's your problem? You get 
the right value already. 

And if you _do_ care about PM_SUSPEND_DISK, then don't ignore it in the
discussion. You can't have it both ways.

The fact is, my laptop can now (finally) do suspend-to-disk. It never 
could do that before. And yes, it does use radeonfb, so your arguments 
hold no water with me. 

I told you what can done to fix things up. Stop ignoring that reality.

		Linus
