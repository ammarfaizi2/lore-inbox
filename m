Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271191AbUJVLQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbUJVLQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271198AbUJVLQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:16:32 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:4363 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271191AbUJVLQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:16:30 -0400
Date: Fri, 22 Oct 2004 12:16:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-ID: <20041022111626.GA18037@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Christoph Lameter <clameter@sgi.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
	linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com> <20041022110116.GA17699@infradead.org> <20041022111259.GQ17038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022111259.GQ17038@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:12:59AM -0700, William Lee Irwin III wrote:
> On Thu, Oct 21, 2004 at 09:58:26PM -0700, Christoph Lameter wrote:
> >> Changelog
> >> 	* overcommit handling
> 
> On Fri, Oct 22, 2004 at 12:01:16PM +0100, Christoph Hellwig wrote:
> > overcommit for huge pages sounds like a realy bad idea.  Care to explain
> > why you want it?
> 
> It's the opposite of what its name implies; it implements strict
> non-overcommit, in the sense that it tries to prevent the sum of
> possible hugetlb allocations arising from handling hugetlb faults from
> exceeding the size of the hugetlb memory pool.

I thought that was the state of the art for hugetlb pages already?
