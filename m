Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTDONFc (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTDONFb 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:05:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261308AbTDONFb 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:05:31 -0400
Date: Tue, 15 Apr 2003 15:17:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Duncan Sands <baldrick@wanadoo.fr>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030415131716.GA814@suse.de>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr> <20030415123134.GM9776@suse.de> <Pine.LNX.4.44.0304151453320.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304151453320.12110-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15 2003, Roman Zippel wrote:
> Hi,
> 
> On Tue, 15 Apr 2003, Jens Axboe wrote:
> 
> > > What happens if you just turn BUG_ON into "do {} while (0)"?
> > 
> > If you do that, you must audit every single BUG_ON to make sure the
> > expression doesn't have any side effects.
> > 
> > 	BUG_ON(do_the_good_stuff());
> 
> This should avoid the problem:
> 
> #define BUG_ON(cond) do { if (cond); } while (0)

Yes I'm aware of the problem being fixable, the above is not likely to
be fast than BUG_ON(). My point was just that you cannot simply count on
being able to make BUG_ON a noop, some thought has to go into it.

-- 
Jens Axboe

