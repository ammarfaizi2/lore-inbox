Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTDOMTs (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTDOMTs 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:19:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21737 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261312AbTDOMTq 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:19:46 -0400
Date: Tue, 15 Apr 2003 14:31:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030415123134.GM9776@suse.de>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151401.00704.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15 2003, Duncan Sands wrote:
> On Monday 14 April 2003 22:19, Martin J. Bligh wrote:
> > Seems all these bug checks are fairly expensive. I can get 1%
> > back on system time for kernel compiles by changing BUG to
> > "do {} while (0)" to make them all compile away. Profiles aren't
> > very revealing though ... seems to be within experimental error ;-(
> 
> What happens if you just turn BUG_ON into "do {} while (0)"?

If you do that, you must audit every single BUG_ON to make sure the
expression doesn't have any side effects.

	BUG_ON(do_the_good_stuff());

-- 
Jens Axboe, proud inventer of BUG_ON :-)

