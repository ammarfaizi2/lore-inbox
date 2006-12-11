Return-Path: <linux-kernel-owner+w=401wt.eu-S1762698AbWLKJgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762698AbWLKJgH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762697AbWLKJgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:36:06 -0500
Received: from twin.jikos.cz ([213.151.79.26]:60980 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762694AbWLKJgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:36:04 -0500
Date: Mon, 11 Dec 2006 10:35:51 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Neil Brown <neilb@suse.de>
cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       linux-raid@vger.kernel.org
Subject: Re: oops on 2.6.19-rc6-mm2: deref of 0x28 at permission+0x7
In-Reply-To: <17788.48732.53210.631230@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0612111034480.1665@twin.jikos.cz>
References: <457A0F4C.9060601@gmail.com> <Pine.LNX.4.64.0612102027350.1665@twin.jikos.cz>
 <17788.48732.53210.631230@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Neil Brown wrote:

> > this nash thing is exactly the command which triggers a bit different 
> > oops in my case. On my side, the oops is fully reproducible. If you 
> > manage to make your case also reproducible, could you please try to 
> > revert md-change-lifetime-rules-for-md-devices.patch? This made the 
> > oops vanish in my case. I think Neil is working on it.
> Trying to work on it - not making a lot of progress.  I find it hard to 
> see how anything in md can cause the inode for a block-device file to 
> disappear... It is a bit of a long-shot, but this patch might change 
> things.  It changes the order in which things are de-allocated. Jiri and 
> Jiri: would either of both of you see if you can reproduce the bug with 
> this patch on 2.6.19-rc6-mm2 ???

Hi Neil,

sorry to say that, but it's still there after applying your patch.

-- 
Jiri Kosina
