Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWC3MFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWC3MFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWC3MFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:05:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51003 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932180AbWC3MFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:05:06 -0500
Date: Thu, 30 Mar 2006 14:05:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330120512.GX13476@suse.de>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330120055.GA10402@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > Hi,
> > 
> > This patch should resolve all issues mentioned so far. I'd still like 
> > to implement the page moving, but that should just be a separate 
> > patch.
> 
> neat stuff. One question: why do we require fdin or fdout to be a pipe?  
> Is there any fundamental problem with implementing what Larry's original 
> paper described too: straight pagecache -> socket transfers? Without a
> pipe intermediary forced inbetween. It only adds unnecessary overhead.

No, not a fundamental problem. I think I even hid that in some comment
in there, at least if it's decipharable by someone else than myself...
Basically I think it would be nice in the future to tidy this a little
bit and separate the actual container from the pipe itself - and have
the pipe just fill/use the same container.

-- 
Jens Axboe

