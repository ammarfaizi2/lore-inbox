Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTKRNhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTKRNhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:37:37 -0500
Received: from gprs147-139.eurotel.cz ([160.218.147.139]:18561 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262686AbTKRNhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:37:34 -0500
Date: Tue, 18 Nov 2003 14:38:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031118133804.GC662@elf.ucw.cz>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de> <20031113125427.GB643@openzaurus.ucw.cz> <20031117081407.GI888@suse.de> <20031118132634.GB470@elf.ucw.cz> <20031118133253.GK888@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118133253.GK888@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > At least idle class can not be used to hold important semaphore
> > forever (even low-priority prosses receive enough time not to hold
> > important semaphores too long)... I believe you should do the same (==
> > get rid of idle class for now, and clearly state that realtime ones
> > are not _guaranteed_ anything).
> 
> That's not doing something about it, that's giving up... 

:-) Yes. That's what we do for scheduler, already. [And its better to
give up than to have DoS security hole, right?]

> You could allow idle prio to proceed, if it holds a resource that could
> potentially block others.

I guess you can't push this for 2.6. And notice that we use same
solution for cpu scheduler, where solution is quite easy (with no
hot-paths overhead).
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
