Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSI0O2W>; Fri, 27 Sep 2002 10:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbSI0O2W>; Fri, 27 Sep 2002 10:28:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261707AbSI0O2U>;
	Fri, 27 Sep 2002 10:28:20 -0400
Date: Fri, 27 Sep 2002 16:33:27 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927143327.GG23468@suse.de>
References: <389902704.1033133455@aslan.scsiguy.com> <200209271426.g8REQ3228125@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209271426.g8REQ3228125@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, James Bottomley wrote:
> Therefore, it is in SCSI's interest to have the OS merge requests if it can 
> purely from the transport efficiency point of view.  Once we accept the 
> necessity of having the OS do some elevator work it becomes detrimental to 
> have this work repeated in the drive firmware.

Hear, hear. And given that the os io scheduler (I prefer to call it
that, elevator is pretty far from the truth :-) gets so close to drives
optimal performance in most cases, a small tag depth makes sense and
protects us from the latency concerns.

> I guess, however, that this issue will evaporate substantially once
> the aic7xxx driver uses ordered tags to represent the transaction
> integrity since the barriers will force the drive seek algorithm to
> follow the tag transmission order much more closely.

Depends on how often you issue these ordered tags, but yes I hope so
too.

-- 
Jens Axboe

