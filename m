Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJVTsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJVTsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUJVTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:46:13 -0400
Received: from holomorphy.com ([207.189.100.168]:30661 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267164AbUJVTks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:40:48 -0400
Date: Fri, 22 Oct 2004 12:40:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [4/4]: Numa patch
Message-ID: <20041022194040.GC17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212158290.3524@schroedinger.engr.sgi.com> <20041022110038.GN17038@holomorphy.com> <Pine.LNX.4.58.0410221235300.9549@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221235300.9549@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:
>> dequeue_huge_page() seems to want a nodemask, not a vma, though I
>> suppose it's not particularly pressing.

On Fri, Oct 22, 2004 at 12:37:13PM -0700, Christoph Lameter wrote:
> How about this variation following __alloc_page:

Looks reasonable. The bit that struck me as quirky was the mpol_* on
the NULL vma. This pretty much eliminates the hidden dispatch, so I'm
happy.


-- wli
