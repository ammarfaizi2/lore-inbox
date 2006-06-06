Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWFFSYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWFFSYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWFFSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:24:08 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:13151 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750796AbWFFSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:24:07 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.64.0606061915370.31871@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com>
	 <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org>
	 <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org>
	 <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org>
	 <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	 <44848DD2.7010506@shadowen.org>
	 <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
	 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
	 <20060605135812.30138205.akpm@osdl.org>
	 <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
	 <1149614184.29059.47.camel@localhost>
	 <Pine.LNX.4.64.0606061039570.27969@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606061915370.31871@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 06 Jun 2006 20:24:08 +0200
Message-Id: <1149618248.29059.81.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 19:21 +0100, Hugh Dickins wrote:
> > Note that there is  still another similar check in there for an arch 
> > specific test of the number of pages available per swap device.
> 
> And that check, also Martin's I believe, has very good justification:
> it will vary from arch to arch how big a swap area they can handle, and
> his check is the right way to do it - no more obscure than it has to be.

Yes, I added that fix since we managed to crash s390 with a swap disk
bigger than 4GB. To keep the symmetry I changed the check for the swap
type as well. 

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


