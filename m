Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWFLGlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWFLGlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWFLGlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:41:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751402AbWFLGlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:41:13 -0400
Date: Mon, 12 Jun 2006 08:41:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Vishal Patil <vishpat@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
Message-ID: <20060612064136.GB4420@suse.de>
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com> <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com> <20060611185854.GF13556@suse.de> <4745278c0606111647g7ca1392bjb46936f69d6b668d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c0606111647g7ca1392bjb46936f69d6b668d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please don't top post)

On Sun, Jun 11 2006, Vishal Patil wrote:
> Jan
> 
> I ran the performance benchmark on an IBM machine with the following
> harddrive attached to it.
> 
> cat /proc/ide/hda/model
> ST340014A

Ok, so plain IDE.

> Also note the CSCAN implementation is using rbtrees due which the time
> complexity of the different operations is O(log(n)) and not O(n) and
> that might be the reason that we are getting good values for specially
> in case of sequential writes and the random workloads.

Extremely unlikely. The sort overhead is completely noise in a test such
as yours, an O(n^2) would likely run just as fast.

-- 
Jens Axboe

