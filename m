Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWG0Ij3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWG0Ij3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWG0Ij3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:39:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53314 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932344AbWG0Ij2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:39:28 -0400
Date: Thu, 27 Jul 2006 10:39:16 +0200
From: Jens Axboe <axboe@suse.de>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727083916.GM5282@suse.de>
References: <20060727081114.GH5282@suse.de> <20060727.012037.78156999.davem@davemloft.net> <20060727082924.GK5282@suse.de> <20060727.013707.101482735.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727.013707.101482735.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27 2006, David Miller wrote:
> From: Jens Axboe <axboe@suse.de>
> Date: Thu, 27 Jul 2006 10:29:24 +0200
> 
> > Precisely. And this is the bit that is currently still broken for
> > splice-to-socket, since it gives that ack right after ->sendpage() has
> > been called. But that's a known deficiency right now, I think Alexey is
> > currently looking at that (as well as receive side support).
> 
> That's right, I was discussing this with him just a few days ago.
> 
> It's good to hear that he's looking at those patches you were working
> on several months ago.

It is. I never ventured much into the networking part, just noted that
as a current limitation with the ->sendpage() based approach. Basically
we need to pass more info in, which also gets rid of the limitation of
passing a single page at the time.

-- 
Jens Axboe

