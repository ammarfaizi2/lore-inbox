Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266268AbUA2Agj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbUA2Agj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:36:39 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:4109 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266268AbUA2Agh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:36:37 -0500
Date: Thu, 29 Jan 2004 08:35:54 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/8] autofs4-2.6 - to support autofs 4.1.x
In-Reply-To: <4017EBA2.1080302@sun.com>
Message-ID: <Pine.LNX.4.44.0401290832020.16657-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REPLY_WITH_QUOTES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, Mike Waychison wrote:

> raven@themaw.net wrote:
> 
> > 
> >Patch:
> >
> >4-autofs4-2.6.0-test9-waitq2.patch
> >
> >Adds a spin lock to serialize access to wait queue in the super block info
> >struct.
> >
> >  
> >
> A while back I wrote up a patch for autofs3 that serialized waitq access 
> and changed the waitq counters to atomic_t.  I never sent it out because 
> I had realized that the changes I made weren't needed as all waitq 
> code-paths were running under the BKL (the big ones were ->lookup and 
> the ioctls). 

My understanding is that this code can be reached at least via lookup, 
readdir and revalidate. I thought that in 2.6 none of these held the BKL 
on entry (I'll have to check). Certainly this is the case for revalidate.

Ian


