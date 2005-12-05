Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVLEUdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVLEUdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVLEUdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:33:18 -0500
Received: from mail.enyo.de ([212.9.189.167]:1697 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751436AbVLEUdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:33:17 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com> <20051203225105.GO31395@stusta.de>
Date: Mon, 05 Dec 2005 21:33:06 +0100
In-Reply-To: <20051203225105.GO31395@stusta.de> (Adrian Bunk's message of
	"Sat, 3 Dec 2005 23:51:05 +0100")
Message-ID: <87hd9n708t.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk:

> I don't get the point where the advantage is when every distribution 
> creates it's own stable branches.

Different vendors have different needs WRT proprietary drivers,
experimental file systems, network stack tweaks.  Their release cycles
aren't synchronized, so it's not clear at which point you can make
sorely needed architectural changes in a stable kernel series (for
example, to fix some egregious performance issues, or complicated
security issues).

> What's wrong with offering an unified branch with few regressions for 
> both users and distributions?

One user's regression is another's bug fix.  And where do those
regressions come from if you don't make any changes in functionality? 8-)

> It's not that every distribution will use 
> it, but as soon as one or two distributions are using it the amount of 
> extra work for maintaining the branch should become pretty low.

Maybe, but I don't see why a vendor should give up its kernel
branding.

You mentioned security issues in your initial post.  I think it would
help immensely if security bugs would be documented properly (affected
versions, configuration requirements, attack range, loss type etc.)
when the bug is fixed, by someone who is familiar with the code.
(Currently, this information is scraped together mostly by security
folks, sometimes after considerable time has passed.)  Having a
central repository with this kind of information would enable vendors
and not-quite-vendors (people who have their own set of kernels for
their machines) to address more vulnerabilties promptly, including
less critical ones.
