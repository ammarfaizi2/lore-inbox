Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUGNTzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUGNTzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGNTzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:55:37 -0400
Received: from thunk.org ([140.239.227.29]:23442 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265398AbUGNTzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:55:36 -0400
Date: Wed, 14 Jul 2004 15:55:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ext3: bump mount count on journal replay
Message-ID: <20040714195526.GF3229@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040714131525.GA1369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714131525.GA1369@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 03:15:25PM +0200, Pavel Machek wrote:
> 
> Currently, you get fsck "just to be sure" once every ~30 clean
> mounts or ~30 hard shutdowns. I believe that hard shutdown is way more
> likely to cause some disk corruption, so it would make sense to fsck
> more often when system is hit by hard shutdown.
> 

At least in theory an unclean shutdown is not going to cause any
problems, unless the hardware is screwy, in which case even a single
hard shutdown is going to cause problems.  I'm not sure that it really
makes sense to arbitrarily state that a hard shutdown is 5 times more
likely to cause problems.  We could make it be configurable, I
suppose, but I'm not sure it's worth it to add all that extra
complexity.  (Heck, we could also argue using a similar reasoning that
software suspends also increases the chances of filesystem corruption
"if something bad happens".  :-)

						- Ted
