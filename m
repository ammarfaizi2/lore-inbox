Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVCCF1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVCCF1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCCFYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:24:10 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:4008 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261465AbVCCFTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:19:47 -0500
Date: Wed, 2 Mar 2005 21:19:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, benh@kernel.crashing.org, anton@samba.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0503022117450.4083@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
 <20050302174507.7991af94.akpm@osdl.org> <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
 <20050302185508.4cd2f618.akpm@osdl.org> <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
 <20050302201425.2b994195.akpm@osdl.org> <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Paul Mackerras wrote:

> More generally, I would be interested to know what sorts of
> applications or benchmarks show scalability problems on large machines
> due to contention on mm->page_table_lock.

Number crunching apps that use vast amounts of memory through MPI or
large databases etc. They stall for a long time during their
initialization phase without these patches.
