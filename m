Return-Path: <linux-kernel-owner+w=401wt.eu-S965231AbXAJXMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbXAJXMf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbXAJXMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:12:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53647 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965231AbXAJXMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:12:34 -0500
Date: Wed, 10 Jan 2007 15:12:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Chinner <dgc@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <20070110230855.GF44411608@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0701101510520.23052@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
 <20070110230855.GF44411608@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, David Chinner wrote:

> Well, pdflush appears to be doing very little on both 2.6.18 and
> 2.6.20-rc3. In both cases kswapd is consuming 10-20% of a CPU and
> all of the pdflush threads combined (I've seen up to 7 active at
> once) use maybe 1-2% of cpu time. This occurs regardless of the
> dirty_ratio setting.

That sounds a bit much for kswapd. How many nodes? Any cpusets in use?

A upper maximum on the number of pdflush threads exists at 8. Are these 
multiple files or single file transfers?

