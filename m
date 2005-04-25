Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVDYVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVDYVKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDYVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:10:12 -0400
Received: from gate.in-addr.de ([212.8.193.158]:6807 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261199AbVDYVJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:09:34 -0400
Date: Mon, 25 Apr 2005 23:09:15 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050425210915.GX32085@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050425203952.GE25002@ca-server1.us.oracle.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-25T13:39:52, Wim Coekaerts <wim.coekaerts@oracle.com> wrote:

> I think it's time we submit ocfs2 w/ it's cluster stack so that folks
> can compare (including actual data/numbers), we have been waiting to
> stabilize everything but I guess there is this preemptive strike going
> on so we might just as well. at least we have had hch and folks comment,
> before sending to submit code.
> 
> Andrew - we will submit ocfs2 so you can have a look, compare and move
> on.  we will work with any stack that eventuslly gets accepted, just want 
> to see the choice out there and an educated decision.

I think "preemptive strike" is a bit over the top, Mr Seklos ;-)

Eventually I am convinced this will end up like much everything else:
One DLM will be better for some things than for some others, and what we
need is reasonably clean modularization and APIs so that people can swap
DLMs et al too; the VFS layer is there for a reason, as is the driver
model.

It's great to see that now two viable solutions are finally being
submitted, and I assume that Bruce will jump in within a couple of hours
too. ;-)

Now that we have two (or three) options with actual users, now is the
right time to finally come up with sane and useful abstractions. This is
great.

(In the past, some, including myself, have been guilty of trying this
the other way around, which didn't work. But it was a worthwhile
experience.)

With APIs, I think we do need a DLM-switch in the kernel, but also the
DLMs should really seem much the same to user-space apps. From what I've
seen, dlmfs is OCFS2 wasn't doing too badly there. The icing would of
course be if even the configuration was roughly similar, and if OCFS2's
configfs might prove valuable to other users too.

The cluster summit in June will certainly be a very ... exciting place.
Let's hope this also stirs up KS a bit ;-)

Oh, and just to anticipate that discussion, anyone who suggests to adopt
the SAF AIS locking API into the kernel should be preemptively struck;
that naming etc is just beyond words.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

