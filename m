Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWBKJtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWBKJtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWBKJtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:49:32 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:29395 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751323AbWBKJtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:49:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 11 Feb 2006 10:50:18 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       Userland Suspend Devel <suspend-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <20060210003533.GJ3389@elf.ucw.cz> <20060211085549.GG8154@blackham.com.au>
In-Reply-To: <20060211085549.GG8154@blackham.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111050.19116.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 11 February 2006 09:55, Bernard Blackham wrote:
> On Fri, Feb 10, 2006 at 01:35:33AM +0100, Pavel Machek wrote:
> > > On Fri, Feb 10, 2006 at 12:35:04AM +0100, Rafael J. Wysocki wrote:
> > > > Now, the question is do we chroot or not?
> > > 
> > > What's wrong with setrlimit(RLIMIT_NOFILE, 0) (and RLIMIT_CORE). So
> > > long as you open all your necessary device nodes before doing so.
> > 
> > Nothing, but we got chroot idea, first.
> 
> Kinda like suspend2 didn't get into the kernel first?

Practically that's 4 lines of setrlimit() code vs 4 lines of chroot()/chdir()
code, so what's the problem?  We can do this, we can do that, and we
can replace this with that at any time, so it really doesn't matter.  Or
if you think it does, please let me know why.

> I still think you're reinventing the wheel, and making it triangular :(

To some extent you are right, but I don't agree with the "triangular"
part.

> I don't understand your motivations for moving something that is so
> intimately tied to the running kernel itself into userspace. A mouse
> driver, sure. But the more I think about it, the more it seems nuts to me.

Could you please provide some arguments?  The more technical/practical they
are, the better.

It is possible you are right and we're just missing something important, so
let's discuss it.  Seriously.

Greetings,
Rafael
