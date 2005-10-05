Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVJERZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVJERZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVJERZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:25:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:13444 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030278AbVJERZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:25:32 -0400
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0510051817560.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
	 <1128531235.26009.35.camel@localhost>
	 <Pine.LNX.4.58.0510051817560.16421@skynet>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:25:22 -0700
Message-Id: <1128533122.26009.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 18:20 +0100, Mel Gorman wrote:
> Changed to
> 
> for (i = 0; (alloctype = fallback_list[i]) != -1; i++) {
> 
> where i is declared a the start of the function. It's essentially the same
> as how we move through the zones fallback list so should seem familiar. Is
> that better?

Yep, at least I understand what it's doing :)

One thing you might consider is not doing the assignment in the for()
body:

	for (i = 0; fallback_list[i] != -1; i++) {
		alloctype = fallback_list[i];
		...

-- Dave

