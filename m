Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWG0XV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWG0XV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWG0XV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:21:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39895 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750873AbWG0XV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:21:27 -0400
Date: Fri, 28 Jul 2006 09:20:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] [xfs] Add lock annotations to xfs_trans_update_ail and xfs_trans_delete_ail
Message-ID: <20060728092035.C2196410@wobbly.melbourne.sgi.com>
References: <1153938323.12517.58.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1153938323.12517.58.camel@josh-work.beaverton.ibm.com>; from josht@us.ibm.com on Wed, Jul 26, 2006 at 11:25:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 11:25:23AM -0700, Josh Triplett wrote:
> xfs_trans_update_ail and xfs_trans_delete_ail get called with the AIL lock
> held, and release it.  Add lock annotations to these two functions (abstracted
> like the AIL lock itself) so that sparse can check callers for lock pairing,
> and so that sparse will not complain about these functions since they
> intentionally use locks in this manner.

Thanks Josh, looks good - I'll get it merged.  I'd prefer to just
open code the use of __acquires/__releases for clarity, but I can
easily make that change before merging.

cheers.

-- 
Nathan
