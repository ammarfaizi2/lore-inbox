Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTFBNXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFBNXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:23:50 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:7585 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262318AbTFBNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:23:48 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1054560974.1918.2.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 09:36:15 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.4, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 03:36, Ingo Molnar wrote:
> On Sat, 31 May 2003, Andrew Morton wrote:
> 
> > >                               [...] Upon looking a little further it
> > >  seemed that the kernel was dynamically boosting the priority of the
> > >  process much higher than it probably should be, in the end, not leaving
> > >  enough CPU for playing the sounds without skipping.
> > 
> > Yes, it seems that too many real-world applications are accidentally
> > triggering this problem.
> 
> no, the problem is exactly the opposite. Here's the key observation:
> 
> > the problem seemed to be caused by the fact that the pluginserver (wine)  
> > was using 100% of the CPU. I simply reniced this process to -10 and
> > everything started working fine.
> 
> the kernel has detected this process to be a CPU-hog - and indeed the
> traces and the above description all say that it really is a CPU hog.
> 
> by renicing it to -10 it gets super-attention from the scheduler, so it
> can be a CPU hog _and_ create sound.

Sorry, this is my fault, I'm actually renicing the process to '10' not
'-10' that's a typo.  I tested this again this morning to make sure. 
I'm renicing this as a regular user, I don't think that a regular user
is allowed to renice to a negative value.

Later,
Tom


