Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTKMQaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTKMQaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:30:05 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:11660 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261806AbTKMQaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:30:01 -0500
Date: Thu, 13 Nov 2003 08:29:45 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113162945.GB2462@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andreas Schwab <schwab@suse.de>, Andrea Arcangeli <andrea@suse.de>,
	Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Davide Libenzi <davidel@xmailserver.org>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com> <3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random> <03Nov13.095622cet.122129@mojo.it.advantest.de> <20031113145301.GJ1649@x30.random> <jen0b047ir.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jen0b047ir.fsf@sykes.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 04:23:24PM +0100, Andreas Schwab wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > On Wed, Nov 12, 2003 at 10:35:22PM +0100, Benoit Poulot-Cazajous wrote:
> >> Andrea Arcangeli <andrea@suse.de> writes:
> >> 
> >> > the usual problem, and the reason we need a sequence number (increased
> >> > before and after the repo update). A file lock not.
> >> 
> >> Or a file that contains md5sums of the other files in the tree. 
> >> After the rsync, you recompute the md5sums file, and if it does not match,
> >> rsync again. As a bonus feature, the md5sums file can be pgp-signed.
> >
> > agreed, this would work too and it has the advantage of working with the
> > mirrors too as far as the per-file updates are atomic (should always be
> > the case). This has the only disavanage of forcing the client and the
> > server to read all file contents (I normally don't rsync with -c).
> 
> This is not necessary, you only need to recompute the md5sums of changed
> files.

If we had this approach we wouldn't have caught the torjan horse in the
CVS tree.  We checksum all the data, changed or not.  Your approach
pushes that duty onto the end users, and let's have a show of hands,
how many of you md5sum every bit of data that you download from the net?
(Please don't reply to that, it's a rhetorical question and I think the
vast majority of the people already know the answer.)
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
