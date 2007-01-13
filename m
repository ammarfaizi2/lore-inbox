Return-Path: <linux-kernel-owner+w=401wt.eu-S1161302AbXAMHnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbXAMHnE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbXAMHnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:43:04 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:46254 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161302AbXAMHnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:43:03 -0500
Date: Fri, 12 Jan 2007 23:42:42 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>, a.p.zijlstra@chello.nl
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-ID: <20070113074242.GB4234@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain> <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com> <20070112214021.GA4300@localhost.localdomain> <Pine.LNX.4.64.0701121341320.3087@schroedinger.engr.sgi.com> <20070113010039.GA8465@localhost.localdomain> <20070112171116.a8f62ecb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112171116.a8f62ecb.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 05:11:16PM -0800, Andrew Morton wrote:
> On Fri, 12 Jan 2007 17:00:39 -0800
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> > But is
> > lru_lock an issue is another question.
> 
> I doubt it, although there might be changes we can make in there to
> work around it.
> 
> <mentions PAGEVEC_SIZE again>

I tested with PAGEVEC_SIZE define to 62 and 126 -- no difference.  I still
notice the atrociously high spin times.

Thanks,
Kiran
