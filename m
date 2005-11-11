Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVKKOU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVKKOU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKKOU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:20:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37783 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750781AbVKKOU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:20:27 -0500
Subject: Re: [PATCH] dequeue a huge page near to this node
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 11 Nov 2005 08:19:25 -0600
Message-Id: <1131718765.13502.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 15:27 -0800, Christoph Lameter wrote:
> The following patch changes the dequeueing to select a huge page near
> the node executing instead of always beginning to check for free 
> nodes from node 0. This will result in a placement of the huge pages near
> the executing processor improving performance.
> 
> The existing implementation can place the huge pages far away from 
> the executing processor causing significant degradation of performance.
> The search starting from zero also means that the lower zones quickly 
> run out of memory. Selecting a huge page near the process distributed the 
> huge pages better.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

I'll add my voice to the chorus of aye's.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

