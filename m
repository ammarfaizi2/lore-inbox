Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCBXaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCBXaD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCBX1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:27:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47019 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261308AbVCBXXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:23:01 -0500
Date: Wed, 2 Mar 2005 18:22:54 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302232253.GC10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302230634.A29815@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:06:34PM +0000, Russell King wrote:
 > On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
 > > In other words, we'd have an increasing level of instability with an odd 
 > > release number, depending on how long-term the instability is.
 > > 
 > >  - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
 > >    patches leading up to it (timeframe: a week or two)
 > > 
 > > with the odd numbers going like:
 > > 
 > >  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
 > >    to it (timeframe: a month or two).
 > >  - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
 > >    several releases (timeframe: a year or two)
 > >  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
 > >    the kernel to be a microkernel using a special message-passing version 
 > >    of Visual Basic. (timeframe: "we expect that he will be released from 
 > >    the mental institution in a decade or two").
 > 
 > This sounds good, until you realise that some of us have been sitting
 > on about 30 patches for at least the last month, because we where
 > following your guidelines about the -rc's.  Things like adding support
 > for new ARM machines and other devices, dynamic tick support for ARM,
 > etc.
 > 
 > If I'm going to have to sit on this stuff for another month, it'll bit
 > rot rather badly, and I might as well throw away all these patches now
 > and ask people not to send stuff other than pure bug fixes.

The fact that this new approach serialises the stable/devel lineation
whereas traditionally it was parallel (2.x.y/2.x+1.y) is going to be
a real pain for a lot of maintainers.

In short, instead of a single 'merge with linus tree', I'm now going to
need a 'merge with linus' and 'merge with linus next time' tree for every
tree I maintain.. It's not impossible to maintain, but its extra burden.
Burden which a lot of folks may consider not worth it.

		Dave

