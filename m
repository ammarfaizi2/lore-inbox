Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTFBOSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFBOSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:18:07 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:41891 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262358AbTFBOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:18:06 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306020937250.2970-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306020937250.2970-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1054564236.4190.15.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 10:30:36 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.4, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 03:39, Ingo Molnar wrote:
> On 1 Jun 2003, Tom Sightler wrote:
> 
> > Yes, this is correct.  It's showed as pluginserver in the 'ps ax' output
> > but I've since noticed that it is simply a symlink to wine.  Of the two
> > wine processes, wine and wineserver, it was the wine frontend process
> > that was getting all of the CPU, showing 100% utilization.  Renicing the
> > wine process made the problem go away.
> > 
> > Running the exact same config on a 2.4.20 kernel uses only a few % of
> > the CPU.
> 
> could you apply the attached patch to 2.5.70 and check whether wine still
> uses up 100% CPU time? This might be an artifact introduced by the
> different HZ values of 2.4 and 2.5.

This made no difference.  I suppose it's important to note that this
problem is much easier to reproduce on pages which have multiple flash
objects.  Actually, the www.disney.com home page (as pointed out by my
daughter) shows the problem better than any page I've found so far.

This page has at least two, very busy, flash objects, including menus
which popup and play sounds as you mouse around the page.  This is the
one that is using nearly 100% of the CPU.

Most other pages, even fairly busy ones, don't seem to make wine use
this much CPU, although there are other pages which show the problem,
just much less.

I'm almost positive that wine doesn't consume that much CPU under 2.4,
but I'm off to run some tests to prove or disprove that right now.

Later,
Tom


