Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUDJRWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUDJRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:22:37 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7814 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262073AbUDJRWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:22:34 -0400
Date: Sat, 10 Apr 2004 19:28:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
Message-ID: <20040410172827.GA2106@mars.ravnborg.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040410131028.A4221@flint.arm.linux.org.uk> <20040410142401.GA2439@mars.ravnborg.org> <20040410153519.C4221@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410153519.C4221@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 03:35:19PM +0100, Russell King wrote:
> On Sat, Apr 10, 2004 at 04:24:01PM +0200, Sam Ravnborg wrote:
> > > 
> > > Therefore, I propose the following patch to detect undefined symbols
> > > in the final image and force an error if this is the case.
> > > 
> > > Comments?
> > 
> > Do we really want to do this for all architectures?
> > You could use something like the attached to restrict it to arm.
> 
> Unfortunately, some people got it into their heads to use the top
> level vmlinux directly, so this wouldn't always catch the problem.
> It really needs to be done immediately after vmlinux is generated
> to ensure that all cases are caught.
OK.

How does output from your nm look?
My version (GNU nm 2.14.90.0.5 20030722 (SuSE Linux)) looks like this:
c04e56ac B zone_table

So I assume an undefined symbol would look like this:
00000000 U undef_symbol

This is not matched by "egrep -q '^ +U '"

	Sam
