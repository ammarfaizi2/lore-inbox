Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVG3NOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVG3NOH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVG3NOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:14:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13988 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262699AbVG3NOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:14:05 -0400
Date: Sat, 30 Jul 2005 15:13:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages in PBE list
Message-ID: <20050730131356.GE1830@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org> <200507301516.32003.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507301516.32003.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	px >= n + x
> > 
> > or
> > 
> > 	(p-1)x >= n
> > 
> > or
> > 
> > 	x >= n / (p-1).
> > 
> > The obvious solution is
> > 
> > 	x = ceiling(n / (p-1)),
> > 
> > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > Michal's patch computes.
> 
> Nice. :-)
> 
> Could we perhaps add your proof to the Michal's patch as a comment,
> for reference?

No, thanks. It only proves that it is equivalent to old code, but says
nothing about quality of code, and we really do not want to keep old
code around.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
