Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbULFHQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbULFHQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 02:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbULFHQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 02:16:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261257AbULFHQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 02:16:46 -0500
Date: Mon, 6 Dec 2004 08:15:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041206071524.GB10498@suse.de>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org> <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Kyle Moffett wrote:
> On Dec 05, 2004, at 21:34, Con Kolivas wrote:
> >I think when nice is changed, ioprio needs to be changed with it as a 
> >sane
> >default action. I suspect that most of the time people will not use the
> >separate ioprio call, but using 'nice' is a regular linuxy thing to 
> >do. Ideally
> >we make ioprio part of the 'nice' utility and we specify both at the 
> >same time.
> >Something like: "nice -n 5 -i 20 blah"
> 
> What about this:
> 
> nice = x;		/* -20 to 20 */
> ioprio = y;		/* -40 to 40 */
> effective_ioprio = clamp(x+y);	/* -20 to 20 */

That's way too many priority levels, there's no way on earth you can
that finely QOS something that you don't have more control over (hard
drive).

-- 
Jens Axboe

