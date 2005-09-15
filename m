Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVIOKAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVIOKAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVIOKAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:00:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38350 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932455AbVIOKAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:00:01 -0400
Date: Thu, 15 Sep 2005 19:59:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ruben Rubio Rey <ruben@rentalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about page allocation failure
Message-ID: <20050915195958.A4873589@wobbly.melbourne.sgi.com>
References: <432914F1.4090001@rentalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <432914F1.4090001@rentalia.com>; from ruben@rentalia.com on Thu, Sep 15, 2005 at 08:30:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:30:09AM +0200, Ruben Rubio Rey wrote:
> Hi,
> 
> Im getting an error: "perl5.8.5: page allocation failure. order:4, 
> mode:0x50".
> 
> What does it means?
> Is it dangerous?
> What may I do to fix it?
> 
> Im using kernel 2.6.9-1.667smp and XFS filesystem.

You have a _heavily_ fragmented file in an XFS filesystem...
there's work underway to prevent this from happening, but for
now you can run xfs_fsr to reduce fragmentation.  XFS retries
the allocation until it succeeds, so its far from optimal but
not dangerous.

cheers.

-- 
Nathan
