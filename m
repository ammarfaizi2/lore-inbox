Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbUJZDUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUJZDUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUJZCxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:53:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:998 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262104AbUJZClJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:41:09 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Date: Mon, 25 Oct 2004 19:40:30 -0700
User-Agent: KMail/1.7
Cc: Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com>
In-Reply-To: <20041026022322.GD17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251940.30574.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 25, 2004 7:23 pm, William Lee Irwin III wrote:
> On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> > - Clearing hugetlb pages is time consuming using clear_highpage in
> > alloc_huge_page. Make it possible to use hw assist via DMA or so there?
>
> It's possible, but it's been found not to be useful. What has been found
> useful is assistance from much lower-level memory hardware of a kind
> not to be had in any extant mass-manufactured machines.

Do you have examples?  SGI hardware has a so-called 'BTE' (for Block Transfer 
Engine) that can arbitrarily zero or copy pages w/o CPU assistance.  It's 
builtin to the memory controller.  Using it to zero the pages has the 
advantages of being asyncrhonous and not hosing the CPU cache.

Jesse
