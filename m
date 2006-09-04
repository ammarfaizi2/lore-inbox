Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWIDFDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWIDFDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIDFDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:03:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41089 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932271AbWIDFDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:03:08 -0400
Date: Mon, 4 Sep 2006 15:02:41 +1000
From: Nathan Scott <nathans@sgi.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting into generic boolean
Message-ID: <20060904150241.I3335706@wobbly.melbourne.sgi.com>
References: <44F833C9.1000208@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44F833C9.1000208@student.ltu.se>; from ricknu-0@student.ltu.se on Fri, Sep 01, 2006 at 03:21:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 03:21:13PM +0200, Richard Knutsson wrote:
> From: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Converting:
> 'B_FALSE' into 'false'
> 'B_TRUE'  into 'true'
> 'boolean_t' into 'bool'

Hmm, so your bool is better than the next guys bool[ean[_t]]? :)

Seems like it'll be a few more days until the next cleanup patch
to remove _that_, so we shouldn't go that path.  Since we do use
the current boolean_t somewhat inconsistently in XFS, I'd say we
should just toss the thing and use int.

I took the earlier patch and completed it, switching over to int
use in place of boolean_t in the few places it used - I'll merge
that at some point, when its had enough testing.

cheers.

-- 
Nathan

-- 
VGER BF report: U 0.496999
