Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWJDLqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWJDLqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030806AbWJDLqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:46:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46240 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030432AbWJDLqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:46:05 -0400
Subject: Re: another attempt to kill off linux/config.h
From: Arjan van de Ven <arjan@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061004112450.GA6858@uranus.ravnborg.org>
References: <20061004074434.GA13672@redhat.com>
	 <20061004112450.GA6858@uranus.ravnborg.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 04 Oct 2006 13:45:32 +0200
Message-Id: <1159962332.3000.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 13:24 +0200, Sam Ravnborg wrote:
> On Wed, Oct 04, 2006 at 03:44:34AM -0400, Dave Jones wrote:
> > Every time I (or someone else) gets a patch included
> > removing explicit includes of linux/config.h, another few creep
> > into the tree a day or so later.
> > 
> > Lets kill them all for good.
> > 
> > master.kernel.org:/pub/scm/linux/kernel/git/davej/configh.git
> > 
> > is a git tree killing off all the current users in tree,
> > and adds a #warn to include/linux/config.h that it's going away.
> > (This should still leave as-yet-unmerged trees compiling,
> >  and hopefully get them fixed before they get merged)
> > We can then remove the file for real just before 2.6.19
> 
> Removing it for real will be a pain for external modules.
> They could of course detect that it is missing and then
> drop it.
> I would suggest to keep the #warning in 2.6.19 and only
> remove it for real for 2.6.20.

they'll have to change anyway; delaying it one release doesn't actually
change that. And you can bet on most modules ignoring the warning anyway
and wait until the thing really is gone... making the value that this
extra delay has basically zero. While the cost is that more false users
will sneak into the kernel ;(

Maybe Fedora can ship with an #error here early on; an #error at least
can provide a helpful message on how to fix it.


