Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTGCM54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTGCM5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:57:55 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:49574 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262169AbTGCM5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:57:53 -0400
Subject: Re: Status of the IO scheduler fixes for 2.4
From: Chris Mason <mason@suse.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <200307031431.27153.m.c.p@wolk-project.de>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
	 <1057197726.20903.1011.camel@tiny.suse.com>
	 <200307031431.27153.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: 
Message-Id: <1057237886.20904.1106.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jul 2003 09:11:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 08:31, Marc-Christian Petersen wrote:
> On Thursday 03 July 2003 04:02, Chris Mason wrote:
> 
> Hi Chris,
> 
> > So, the patch attached includes the q->full code but has it off by
> > default.  I've got code locally for an elvtune interface that can toggle
> > q->full check on a per device basis, as well as tune the max io per
> > queue.  I've got two choices on how to submit it, I can either add a new
> > ioctl or abuse the max_bomb_segments field in the existing ioctl.
> > If we can agree on the userland tuning side, I can have some kind of
> > elvtune patch tomorrow.
> what about /proc ?

Always an option.  If elvtune didn't exist at all I'd say proc was a
better choice.  But I do want to be able to tune things on a per device
basis, which probably means a new directory tree somewhere in proc.  Our
chances are only 50/50 of getting that patch in without a long thread
about the one true way to access kernel tunables through an fs 
interface visible to userland ;-)

For the most part I'm only visiting drivers/block/*.c right now, so I'll
code whatever interface the long term maintainers hate the least.

-chris


