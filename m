Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVLFBbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVLFBbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVLFBbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:31:41 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:62606 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964903AbVLFBbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:31:40 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20051205233430.GA1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
	 <1133816579.3872.83.camel@localhost>  <20051205233430.GA1770@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133832410.6360.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 11:26:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-12-06 at 09:34, Pavel Machek wrote:
> > > If goal is "make it work with least effort", answer is of course
> > > suspend2; but I need someone to help me doing it right.
> > 
> > How do you think suspend2 does it wrong? Is it just that you think that
> > everything belongs in userspace, or is there more to it?
> 
> Everything belongs in userspace... that makes it "wrong
> enough". Userland and kernel programming is quite different, so any
> improvements to suspend2 will be wasted, long-term. You'll make users
> happy for now, but it means u-swsusp gets less users and less
> developers, making "doing it right" slightly harder...

Ok. I guess I need help then in seeing why everything belongs in
userspace. Actually, let's revise that for a start - I know you don't
really mean everything, because even you still do the atomic copy in
kernel space... or are you planning on changing that too? :)

I'm not unwilling to be convinced - I just don't see why, with such a
lowlevel operation as suspending to disk, userspace is the place to put
everything. The preference for userspace seems to me to be just that - a
preference.

Regarding improvements to suspend2 being wasted long term, I actually
think that I could port at least part of it to userspace without too
much effort at all. My main concern would be exporting the information
and interfaces needed in a way that isn't ugly, is reliable and doesn't
open security holes. I'm not at all convinced that kmem meets those
criteria. But if you can show me a better way, I'll happily come on
board.

Regards,

Nigel

