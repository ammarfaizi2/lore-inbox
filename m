Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271199AbUJVLNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271199AbUJVLNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbUJVLNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:13:19 -0400
Received: from holomorphy.com ([207.189.100.168]:9666 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271191AbUJVLNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:13:10 -0400
Date: Fri, 22 Oct 2004 04:12:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-ID: <20041022111259.GQ17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com> <20041022110116.GA17699@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022110116.GA17699@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:58:26PM -0700, Christoph Lameter wrote:
>> Changelog
>> 	* overcommit handling

On Fri, Oct 22, 2004 at 12:01:16PM +0100, Christoph Hellwig wrote:
> overcommit for huge pages sounds like a realy bad idea.  Care to explain
> why you want it?

It's the opposite of what its name implies; it implements strict
non-overcommit, in the sense that it tries to prevent the sum of
possible hugetlb allocations arising from handling hugetlb faults from
exceeding the size of the hugetlb memory pool.


-- wli
