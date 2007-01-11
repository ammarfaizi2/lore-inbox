Return-Path: <linux-kernel-owner+w=401wt.eu-S965286AbXAKBLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbXAKBLW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbXAKBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:11:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38876 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965286AbXAKBLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:11:21 -0500
Date: Thu, 11 Jan 2007 12:11:05 +1100
From: David Chinner <dgc@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
Message-ID: <20070111011105.GV33919298@melbourne.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110230855.GF44411608@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:08:55AM +1100, David Chinner wrote:
> On Wed, Jan 10, 2007 at 03:04:15PM -0800, Christoph Lameter wrote:
> > On Thu, 11 Jan 2007, David Chinner wrote:
> > 
> > > The performance and smoothness is fully restored on 2.6.20-rc3
> > > by setting dirty_ratio down to 10 (from the default 40), so
> > > something in the VM is not working as well as it used to....
> > 
> > dirty_background_ratio is left as is at 10?
> 
> Yes.

FWIW, setting dirty_ratio to 20 instead of 10 fixes the most of
the erraticness of the writeback and most of the performance as well.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
