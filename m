Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbTHZIII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTHZIII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:08:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15525 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262514AbTHZIIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:08:06 -0400
Date: Tue, 26 Aug 2003 10:07:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH  odd code in bio_add_page
Message-ID: <20030826080756.GB862@suse.de>
References: <16202.51771.638332.396242@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16202.51771.638332.396242@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Neil Brown wrote:
> 
> I was just taking a closer look at bio_add_page and there is some code
> that doesn't mage sense.  The following patch explains the problem and
> suggests a possible fix.
> 
> NeilBrown
> 
> 
> ==================================================
> Fix strange code in bio_add_page
> 
> With the current code in bio_add_page, if fail_segments is ever set,
> it stays set, so bio_add_page will eventually fail having recounted
> the segmentation once.
> 
> I don't think this is intended.  This patch changes the code to allow
> success if the recounting the segments helps.

Good catch Neil, I agree with the fix.

-- 
Jens Axboe

