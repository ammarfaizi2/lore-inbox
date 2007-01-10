Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbXAJXJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbXAJXJT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbXAJXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:09:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36614 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965171AbXAJXJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:09:17 -0500
Date: Thu, 11 Jan 2007 10:08:55 +1100
From: David Chinner <dgc@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
Message-ID: <20070110230855.GF44411608@melbourne.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 03:04:15PM -0800, Christoph Lameter wrote:
> On Thu, 11 Jan 2007, David Chinner wrote:
> 
> > The performance and smoothness is fully restored on 2.6.20-rc3
> > by setting dirty_ratio down to 10 (from the default 40), so
> > something in the VM is not working as well as it used to....
> 
> dirty_background_ratio is left as is at 10?

Yes.

> So you gain performance by switching off background writes via pdflush?

Well, pdflush appears to be doing very little on both 2.6.18 and
2.6.20-rc3. In both cases kswapd is consuming 10-20% of a CPU and
all of the pdflush threads combined (I've seen up to 7 active at
once) use maybe 1-2% of cpu time. This occurs regardless of the
dirty_ratio setting.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
