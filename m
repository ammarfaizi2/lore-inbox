Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUKPO3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUKPO3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKPO1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:27:55 -0500
Received: from holomorphy.com ([207.189.100.168]:19133 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261974AbUKPOY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:24:58 -0500
Date: Tue, 16 Nov 2004 06:24:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 4/4] Cleanup file_count usage: Avoid file_count usage for hugetlb nattach reporting
Message-ID: <20041116142446.GM3217@holomorphy.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com> <20041116141125.GE23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116141125.GE23257@impedimenta.in.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 07:41:25PM +0530, Ravikiran G Thirumalai wrote:
> The file_count macro usage to get the number of attaches to a hugetlb
> sysv style shared memory segment, seems to work although it looks bogus
> on the first look.  But we want to get rid of file_count macros and 
> reads to struct file.f_count.  This patch cleans up the file_count usage
> for shm hugetlb attaches.  The nattch counter is maintained on the same 
> lines as in regular sysv shared memory segments. The file_operations for the 
> struct file of the shared memory hugetlb segment now is different from the
> hugetlbfs specific f_ops. 
> Patch has been tested with some userspace testcases
> Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

I'm generally in favor of getting rid of the ->f_count twiddling from
hugetlb, though I've not reviewed this closely.


-- wli
