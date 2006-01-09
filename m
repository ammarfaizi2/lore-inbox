Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWAISnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWAISnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWAISnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:43:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:18615 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030242AbWAISnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:43:50 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Console debugging wishlist was: Re: oops pauser.
References: <20060105045212.GA15789@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Jan 2006 19:43:46 +0100
In-Reply-To: <20060105045212.GA15789@redhat.com>
Message-ID: <p73vewtw8bh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> In my quest to get better debug data from users in Fedora bug reports,
> I came up with this patch.  A majority of users don't have serial
> consoles, so when an oops scrolls off the top of the screen,
> and locks up, they usually end up reporting a 2nd (or later) oops
> that isn't particularly helpful (or worse, some inconsequential
> info like 'sleeping whilst atomic' warnings)

Ok - here's my personal wishlist. If someone is interested ...

What I would like to have is a "more" option for the kernel that makes
it page kernel output like "more" and asks you before scrolling
to the next page.

What would be also cool would be to fix the VGA console to have 
a larger scroll back buffer.  The standard kernel boot output 
is far larger than the default scrollback, so if you get a hang
late you have no way to look back to all the earlier 
messages.

(it is hard to understand that with 128MB+ graphic cards and 512+MB
computers the scroll back must be still so short...) 

And fixing sysrq to work after panics would be also nice.

And maybe a sysrq key to switch the font to the smallest one available
so as much as possible would fit onto a digital photo.
> 
> The one case this doesn't catch is the problem of oopses whilst
> in X. Previously a non-fatal oops would stall X momentarily,
> and then things continue. Now those cases will lock up completely
> for two minutes. Future patches could add some additional feedback
> during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.

That's the killer issues why this patch is a bad idea.

-Andi
