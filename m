Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTDOM3D (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTDOM3D 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:29:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54764 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261309AbTDOM3B 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:29:01 -0400
Date: Tue, 15 Apr 2003 14:40:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Duncan Sands <baldrick@wanadoo.fr>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030415124033.GN9776@suse.de>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr> <20030415123134.GM9776@suse.de> <20030415123641.GA13966@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415123641.GA13966@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15 2003, Dave Jones wrote:
> On Tue, Apr 15, 2003 at 02:31:34PM +0200, Jens Axboe wrote:
> 
>  > If you do that, you must audit every single BUG_ON to make sure the
>  > expression doesn't have any side effects.
>  > 
>  > 	BUG_ON(do_the_good_stuff());
> 
> Sure, but such a construct looks really bad anyway.
> Relying on side-effects of whats essentially a debug macro
> sounds very dodgy.
> 
> 	foo = do_the_good_stuff();
> 	BUG_ON (foo==baz)
> 
> Would be a better way of expressing this.

Oh I agree, it wasn't an example of good code :). It still needs to be
audited though.

-- 
Jens Axboe

