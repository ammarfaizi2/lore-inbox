Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbUDNM1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUDNM1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:27:31 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:774 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264076AbUDNM12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:27:28 -0400
Date: Wed, 14 Apr 2004 20:31:59 +0800 (WST)
From: raven@themaw.net
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
In-Reply-To: <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
 <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Apr 14, 2004 at 08:12:33PM +0800, raven@themaw.net wrote:
> > On Wed, 14 Apr 2004, Hugh Dickins wrote:
> > 
> > > After chdir (or chroot) to non-existent directory on 2.6.5-mm5, you
> > > can no longer unmount filesystem holding working directory (or root).
> > > 
> > 
> > Of course.
> > 
> > Excellent. Thanks very much.
> 
> Mind you, chdir() patch in -mm is broken in a lot of other ways - e.g.
> it assumes that another thread sharing ->fs with us won't call chdir()
> in the wrong moment...

Thanks for your interest Al.

I see your point (I think).

If I understand you correctly (please explain if I don't) I need to lock 
the ->fs struct.
But then I can't use the set_fs_xxx calls.

Do you have any suggestions on how I should do this?

Ian

