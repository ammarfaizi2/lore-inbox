Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUEBSTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUEBSTp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUEBSTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 14:19:45 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:10116 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263184AbUEBSTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 14:19:44 -0400
Date: Sun, 2 May 2004 11:19:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz, koke@amedias.org,
       linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502181935.GA30249@taniwha.stupidest.org>
References: <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org> <20040502090059.A9605@flint.arm.linux.org.uk> <20040502011337.2b0b3ca3.akpm@osdl.org> <20040502091751.B9605@flint.arm.linux.org.uk> <20040502103721.C9605@flint.arm.linux.org.uk> <20040502111729.D9605@flint.arm.linux.org.uk> <20040502135424.GA20578@apps.cwi.nl> <20040502175326.GA30108@taniwha.stupidest.org> <20040502190115.D17905@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502190425.E17905@flint.arm.linux.org.uk> <20040502190115.D17905@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 07:01:15PM +0100, Russell King wrote:

> As I read the original problem, you have gdm running on what it
> thought was a free tty at the time.  agetty starts up and takes
> control of the tty.

Heh, I wasn't thinking about gdm, I was thinking more about rogue
programs keeping the tty open after the user has gone.

On Sun, May 02, 2004 at 07:04:25PM +0100, Russell King wrote:

> Oh, and also on this note, vhangup may be a good idea just before
> displaying the issue message.

I was more concerned about security issues with an evil program
hanging out.  Since login is actually where the password is read and
it does use vhangup, then we don't need to worry.

So yes, using tty locking would seem the the sensible solution.


   --cw
