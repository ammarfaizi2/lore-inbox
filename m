Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUEBRxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUEBRxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUEBRxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 13:53:37 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:34285 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263169AbUEBRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 13:53:35 -0400
Date: Sun, 2 May 2004 10:53:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz, koke@amedias.org,
       linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502175326.GA30108@taniwha.stupidest.org>
References: <20040502135424.GA20578@apps.cwi.nl> <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org> <20040502090059.A9605@flint.arm.linux.org.uk> <20040502011337.2b0b3ca3.akpm@osdl.org> <20040502091751.B9605@flint.arm.linux.org.uk> <20040502103721.C9605@flint.arm.linux.org.uk> <20040502111729.D9605@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502135424.GA20578@apps.cwi.nl> <20040502111729.D9605@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 11:17:29AM +0100, Russell King wrote:

> The first one is of particular note, because it is the cause of the
> GROSS hack in agetty, which according to the comments is also in
> gdm.

I've emailed the debian util-linux maintainer about this.

> I wonder really if the problem was elsewhere, and if Debian wanted
> to take care of this problem, why they didn't just take the serial
> line locking solution (really: s/serial line/tty/) and apply it to
> agetty / gdm.

It locking really the way to do this?  What's wrong with vhangup?


On Sun, May 02, 2004 at 03:54:24PM +0200, Andries Brouwer wrote:

> However, my agetty source does not contain the string VT_OPENQRY.  I
> suppose this is a private Debian change. Maybe you should contact
> Debian people to find out who did this and why.

Sorry, I used 'apt-get source' to get the source code and completely
forgot about the fact it would patch the package.

> (And/or try the vanilla agetty to see whether the problems go away.)

Vanilla will work as expected.  It still doesn't seem to prevent the
case where someone could terminate and leave a process running that
would take input later on though...  at least not that I can see.


Anyhow, this for not is clearly a userspace issue so sorry about all
the noise people.


   --cw
