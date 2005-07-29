Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVG2TGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVG2TGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVG2TD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:03:57 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60338 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262731AbVG2TB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:01:58 -0400
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       perex@suse.cz, Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
	 <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
	 <20050728213543.6264ca60.akpm@osdl.org>
	 <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
	 <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 29 Jul 2005 15:01:36 -0400
Message-Id: <1122663696.29823.264.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-29 at 10:29 -0700, Linus Torvalds wrote:
> 
> On Fri, 29 Jul 2005, Cal Peake wrote:
> > 
> > Thanks Andrew! Indeed your suspicions are correct. Adding in all the 
> > debugging moved the problem around, it now shows itself when probing 
> > parport. Upon further investigation reverting the commit below seems to 
> > have nixed the problem.
> 
> Thanks. Just out of interest, does this patch fix it instead?

Oops,  never thought that size would be zero coming in.  I originally
had it as a while() instead of a do while but thought that I could speed
it up if the first word succeeded.  Sorry for that. I blame it on it
being late when I wrote it and trying several different ways. :-P

-- Steve
 

