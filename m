Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTEYAa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 20:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTEYAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 20:30:58 -0400
Received: from mout0.freenet.de ([194.97.50.131]:25728 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261222AbTEYAa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 20:30:57 -0400
From: Christian Klose <christian.klose@freenet.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Sun, 25 May 2003 02:43:59 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305231405.54599.christian.klose@freenet.de> <200305241615.49463.m.c.p@wolk-project.de> <20030524142809.GZ8978@holomorphy.com>
In-Reply-To: <20030524142809.GZ8978@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305250242.58269.christian.klose@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 May 2003 16:28, William Lee Irwin III wrote:

Hi wli,

> > --- old/kernel/sched.c	2003-05-24 14:45:57.000000000 +0200
> > +++ 2.5-mcp/kernel/sched.c	2003-05-24 16:18:42.000000000 +0200
> > @@ -65,7 +65,7 @@
> >   * they expire.
> >   */
> >  #define MIN_TIMESLICE		( 10 * HZ / 1000)
> > -#define MAX_TIMESLICE		(200 * HZ / 1000)
> > +#define MAX_TIMESLICE		( 10 * HZ / 1000)
> >  #define CHILD_PENALTY		50
> >  #define PARENT_PENALTY		100
> >  #define EXIT_WEIGHT		3

> This looks highly suspicious as it essentially removes dynamic timeslice
> sizing. If this fixes something, then dynamic timeslice heuristics are
> going wrong somewhere that should be properly described and handled, not
> this kind of shenanigan.
I somewhat agree with you but this "properly described" are all the bug 
reports on lkml containing "bad interactivity in 2.5, cpu starving in 2.5" 
and such...

This isn't a shenanigan, at least not for the interactivity for a desktop. 
This is a workaround for users who are complaining about bad interactivity in 
2.5!

ciao, Marc


