Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287379AbSACQ2i>; Thu, 3 Jan 2002 11:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSACQ22>; Thu, 3 Jan 2002 11:28:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36364 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287379AbSACQ2O>;
	Thu, 3 Jan 2002 11:28:14 -0500
Date: Thu, 3 Jan 2002 17:26:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird application breakage in 2.5.2-pre5
Message-ID: <20020103172641.D6267@suse.de>
In-Reply-To: <m16M9Bl-0005kjC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16M9Bl-0005kjC@gherkin.frus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03 2002, Bob_Tracy wrote:
> The application is elm2.4.ME+.82 with PGP 6.5.8.  Works fine under
> kernel version 2.4.17.  Under 2.5.2-pre5, when I try to encrypt+sign
> a message to a particular recipient for which I have two matching keys
> on my pgp keyring, no matching pgp key is found.  The *only* difference
> between "works" and "doesn't" is the kernel version.
> 
> Cranked up the debug level on elm in an attempt to see what's happening,
> and at level 41, I notice that the parent (elm) isn't reading anything
> from the child (pgp -kv recipient_address).  No error indication of any
> kind, so fork(), pipe(), execl(), fdopen(), and fgets() all seem to be
> happy.
> 
> libc version is 2.2.3.
> 
> Possible side-effect of bio changes?

very unlikely I would say, maybe it's an odd scheduler interaction?

-- 
Jens Axboe

