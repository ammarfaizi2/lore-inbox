Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbUCXPSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUCXPSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:18:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7080 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263739AbUCXPSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:18:32 -0500
Date: Wed, 24 Mar 2004 16:18:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324151831.GB25738@atrey.karlin.mff.cuni.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403240748.31837.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Except when it is not in syslog, because it was after atomic copy or
> > before atomic copy back. swsusp is pretty unique in this respect.
> >
> 
> And I would consider an error that happens after atomic copy critical. If
> this happens all attempts to draw progress bar, etc. should be stopped and
> suspend should probably abort as well.

Well, not all printks() are errors this hard. And at some points, it
is no longer possible to abort (after pagedir is on disk, its okay to
panic (machine will resume normally after that), but its not okay to
simply return. You could fix signature then return, but it would be hard). 

> What happens if swsusp1 gets such an error during atomic phase? Will it
> continue or abort? If it continues I would imagine user not noticing the
> message it it flashes the split second before the box powers off. 

It continues. Fortunately powerdown takes enough time on most machines
that messages can be readed ... if you pay attetion.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
