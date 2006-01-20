Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWATRhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWATRhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWATRhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:37:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6193 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751108AbWATRho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:37:44 -0500
Date: Fri, 20 Jan 2006 18:39:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060120173939.GN13429@suse.de>
References: <89E85E0168AD994693B574C80EDB9C27035561DE@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27035561DE@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20 2006, Andy Chittenden wrote:
> > Andy, can you try and boot with this applied?
> 
> At boot,
> 
> # dmesg | grep bounce:
> bounce: queue ffff81013fa5cd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5ca88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c7f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c2d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93bd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93ba88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b7f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b2d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31d18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31a88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa317f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa312d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa312d8, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013fa31048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31048, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fa88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fa88, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013f51f7f8, setting pfn 1310720, max_low 1310720
> 
> No change when I ran the test.

Please include the full dmesg, so I can see which queue is what. Most of
them look ok (1310720 is BLK_BOUNCE_HIGH), 1048575 is a little weird
though. So full dmesg please!

Perhaps this is a wrapping problem of some sort.

-- 
Jens Axboe

