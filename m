Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbUDNPJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUDNPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:09:36 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:36870 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264248AbUDNPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:09:34 -0400
Date: Wed, 14 Apr 2004 23:13:13 +0800 (WST)
From: raven@themaw.net
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
In-Reply-To: <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net>
Message-ID: <Pine.LNX.4.58.0404142308260.20568@donald.themaw.net>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
 <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 raven@themaw.net wrote:

> > Mind you, chdir() patch in -mm is broken in a lot of other ways - e.g.
> > it assumes that another thread sharing ->fs with us won't call chdir()
> > in the wrong moment...
> 
> Thanks for your interest Al.
> 
> I see your point (I think).
> 
> If I understand you correctly (please explain if I don't) I need to lock 
> the ->fs struct.

Mmm ... doesn't look much good in the light of Als comment.

Looks like it's not possible to take the lock for long enough even if I 
could.

Lets have some comments, criticisms or suggestions please.

Ian

