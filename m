Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUJZC4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUJZC4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUJZC4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:56:01 -0400
Received: from holomorphy.com ([207.189.100.168]:55520 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262060AbUJZCqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:46:44 -0400
Date: Mon, 25 Oct 2004 19:43:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041026024327.GF17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410251940.30574.jbarnes@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
>>> - Clearing hugetlb pages is time consuming using clear_highpage in
>>> alloc_huge_page. Make it possible to use hw assist via DMA or so there?

On Monday, October 25, 2004 7:23 pm, William Lee Irwin III wrote:
>> It's possible, but it's been found not to be useful. What has been found
>> useful is assistance from much lower-level memory hardware of a kind
>> not to be had in any extant mass-manufactured machines.

On Mon, Oct 25, 2004 at 07:40:30PM -0700, Jesse Barnes wrote:
> Do you have examples?  SGI hardware has a so-called 'BTE' (for Block Transfer 
> Engine) that can arbitrarily zero or copy pages w/o CPU assistance.  It's 
> builtin to the memory controller.  Using it to zero the pages has the 
> advantages of being asyncrhonous and not hosing the CPU cache.

That's the same kind of thing, so it apparently has been
mass-manufactured.


-- wli
