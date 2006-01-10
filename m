Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWAJUqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAJUqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWAJUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:46:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:17569 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932345AbWAJUqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:46:48 -0500
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Tue, 10 Jan 2006 21:45:53 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601102145.53967.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 21:25, Jan Engelhardt wrote:
> An oops is usually a condition you can recover from in some/most/depends 
> cases (e.g. a null deref in a filesystem "only" makes that vfsmount 
> (filesystem at all?) blocked), so if the kernel is waiting for user input 
> on a non-panic condition, this means userspace stops too, which is not 
> too good if the kernel is still 'alive'.
> It's like we are entering kdb although everything is fine enough to go 
> through a proper `init 6`.

-ENOPARSE

> 
> >What would be also cool would be to fix the VGA console to have 
> >a larger scroll back buffer.  The standard kernel boot output 
> >is far larger than the default scrollback, so if you get a hang
> >late you have no way to look back to all the earlier 
> >messages.
> >
> >(it is hard to understand that with 128MB+ graphic cards and 512+MB
> >computers the scroll back must be still so short...) 
> 
> I doubt this scrollback buffer is implemented as part of the video cards. 
> It is rather a kernel invention, and therefore uses standard RAM. But the 
> idea is good, preferably make it a CONFIG_ option.

At least long ago (when I last looked) it was in video RAM. 

> 
> >And fixing sysrq to work after panics would be also nice.
> 
> I am not sure, but would enabling interrupts be enough?

Interrupts are already enabled, but no - it's not.

Thank you for an useful contribution to the thread.

-Andi
