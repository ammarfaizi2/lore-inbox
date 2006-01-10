Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWAJOZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWAJOZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWAJOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:25:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751042AbWAJOZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:25:21 -0500
Date: Tue, 10 Jan 2006 15:25:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110142540.GK3389@suse.de>
References: <20060110125852.GA3389@suse.de> <17347.47882.735057.154898@alkaid.it.uu.se> <20060110135404.GF3389@suse.de> <43C3C023.9040308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3C023.9040308@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Gerd Hoffmann wrote:
> changing PAGE_OFFSET.  As the whole point of this split patchery is to 
> avoid highmem in the first place it maybe makes sense to have some 
> "optimize for 1/2/4/more GB main memory" config option which in turn 
> picks sane PAGE_OFFSET+HIGHMEM+PAE settings?

Forgot to comment on that... Yes that is indeed an option, but it's a
little complicated since it depends on the role of the machine. A file
server may want a very small user land virtual memory size, whereas a
database server may want the opposite. So I think it's still saner to
expose a select range of settings.

-- 
Jens Axboe

