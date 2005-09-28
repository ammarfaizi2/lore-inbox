Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVI1VSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVI1VSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVI1VSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:18:43 -0400
Received: from dvhart.com ([64.146.134.43]:64909 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750782AbVI1VSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:18:42 -0400
Date: Wed, 28 Sep 2005 14:18:38 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <clameter@engr.sgi.com>,
       "Seth, Rohit" <rohit.seth@intel.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
Message-ID: <15630000.1127942318@flay>
In-Reply-To: <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com> <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, September 28, 2005 13:01:23 -0700 Christoph Lameter <clameter@engr.sgi.com> wrote:

> On Wed, 28 Sep 2005, Seth, Rohit wrote:
> 
>> Recent changes in page allocations for pcps has increased the high watermark for these lists.  This has resulted in scenarios where pcp lists could be having bigger number of free pages even under low memory conditions. 
>> 
>>  	[PATCH]: Reduce the high mark in cpu's pcp lists.
> 
> There is no need for such a patch. The pcp lists are regularly flushed.
> See drain_remote_pages.

That's only retrieving pages which have migrated off-node, is it not?

M.


