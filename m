Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUIIOlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUIIOlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUIIOlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:41:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27095 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264997AbUIIOiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:38:13 -0400
Date: Thu, 9 Sep 2004 16:36:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix leak with bounced bio's
Message-ID: <20040909143656.GB1737@suse.de>
References: <20040909084204.GO1737@suse.de> <414069DF.9000804@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414069DF.9000804@bio.ifi.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Frank Steiner wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >This might fix the last leak of memory reported with cd writing, the
> >current highmem bounce code will leak n-1 pages for any n page bio where
> >n > 1. CD writing typically uses 16 pages bios, so it is affected.
> 
> 
> it fixes the leak for us that I described a while back
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109360958318479&w=2
> 
> Great :-))

Great, thanks for confirming!

Maybe we should unconditionally bounce all bios for a while in a test
kernel, to make sure that all bouncing bugs are shaken out ;-)

-- 
Jens Axboe

