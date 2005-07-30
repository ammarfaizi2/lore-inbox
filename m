Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVG3OhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVG3OhY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVG3OhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:37:24 -0400
Received: from mx1.rowland.org ([192.131.102.7]:26642 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S262972AbVG3OhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:37:17 -0400
Date: Sat, 30 Jul 2005 10:37:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Pavel Machek <pavel@ucw.cz>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of
 pages in PBE list
In-Reply-To: <200507301532.59576.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0507301035400.31323-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:

> Hi,
> 
> On Saturday, 30 of July 2005 15:13, Pavel Machek wrote:
> > Hi!
> > 
> > > > 	px >= n + x
> > > > 
> > > > or
> > > > 
> > > > 	(p-1)x >= n
> > > > 
> > > > or
> > > > 
> > > > 	x >= n / (p-1).
> > > > 
> > > > The obvious solution is
> > > > 
> > > > 	x = ceiling(n / (p-1)),
> > > > 
> > > > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > > > Michal's patch computes.
> > > 
> > > Nice. :-)
> > > 
> > > Could we perhaps add your proof to the Michal's patch as a comment,
> > > for reference?
> > 
> > No, thanks. It only proves that it is equivalent to old code, but says
> > nothing about quality of code, and we really do not want to keep old
> > code around.
> 
> IMHO it rather says that the formula is OK and would save some time to
> people reading the code for the _first_ time and trying to understand it,
> but you decide. :-)

It's up to you whether or not to include the proof as a comment -- you 
have my permission and my sign-off:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

