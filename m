Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271379AbTHDFkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271386AbTHDFkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:40:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15323 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271379AbTHDFky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:40:54 -0400
Date: Mon, 4 Aug 2003 07:40:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
Message-ID: <20030804054020.GV7920@suse.de>
References: <3F2D1884.3010001@colorfullife.com> <1059920721.3524.137.camel@gaston> <3F2D2BBA.70205@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2D2BBA.70205@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03 2003, Lou Langholtz wrote:
> Benjamin Herrenschmidt wrote:
> 
> >>The last step is bad - sooner or later the queue will be kfreed, and if 
> >>there are bozos around that still have references, they would access 
> >>random memory. It must be guaranteed that all references expired before 
> >>the tear down begins. Just leaving a dead flag set is not sufficient.
> >>   
> >>
> >Jens ? I see no refcounting of the queue,. . .
> >
> struct request_queue's kobj field perhaps?

Queue still needs dynamically allocated for this to work, and it isn't.
This is one of Al's projects, but he seems to be busy and/or away. It's
pretty straight forward but pretty massive change, wonder if Linus could
be talked into it...

-- 
Jens Axboe

