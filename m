Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270764AbTG0MsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTG0MsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:48:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51428 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270764AbTG0MsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:48:19 -0400
Date: Sun, 27 Jul 2003 14:47:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]  Block layer bug handling partial bvec
Message-ID: <20030727124750.GB2261@suse.de>
References: <099001c35434$f9ac3130$7f0a0a0a@lappy7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099001c35434$f9ac3130$7f0a0a0a@lappy7>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27 2003, Sean Estabrooks wrote:
> Previously I submitted a patch for "blk: request botched" on floppy
> write.  While the patch did make the floppy work, Jens mentioned 
> that an underlying error still existed.   This spurred me on to look a 
> little deeper and finally i found the root cause.   
> 
> There is a bug in "ll_rw_blk.c" handling partial bvec submissions.
> For whatever reason the floppy driver was triggering it more than
> other users.  Note that with the attached patch, my previous 
> floppy_ patch is no longer needed.

Good catch! Applied.

-- 
Jens Axboe

