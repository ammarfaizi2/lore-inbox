Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUBQURg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266581AbUBQURg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:17:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266580AbUBQURb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:17:31 -0500
Date: Tue, 17 Feb 2004 20:17:30 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040217201730.GR8858@parcelfarce.linux.theplanet.co.uk>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org> <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <Pine.LNX.4.58.0402170833110.2154@home.osdl.org> <20040217194414.GP8858@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402171153460.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171153460.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 12:10:23PM -0800, Linus Torvalds wrote:
> I do believe we'd need to have some way to "refresh" the fd in your
> example, without restarting the whole lookup. So that when the user gets 
> EFOAD, it can do
> 
> 	refresh(fd);

lseek(fd, 0, 0);

> > And we really don't want to encourage those who port Windows userland in
> > not fixing the idiotic semantics.  As for Lindows... let's just say that
> > I can't find any way to describe what I really think of those clowns, their
> > intellect and their morals that wouldn't lead to a lawsuit from them.
> 
> Heh.
> 
> I suspect most people don't care that much, but I also suspect that 
> projects like samba have to have a "anal mode" where they really act like 
> Windows, even when it's "wrong". People can then choose to say "screw that 
> idiocy", but by just _having_ a very compatible mode you deflect a lot of 
> criticism. Regardless of whether people want the anal mode or not in real 
> life.

Umm...  Samba deals with Windows clients.  Windows software allegedly being
ported to Linux is a different story and in that case there's no excuse for
demanding case-insensitive operations.
