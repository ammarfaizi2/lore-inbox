Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTFYBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTFYBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:16:55 -0400
Received: from holomorphy.com ([66.224.33.161]:21723 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264372AbTFYBQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:16:48 -0400
Date: Tue, 24 Jun 2003 18:30:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030625013050.GQ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306250307.18291.phillips@arcor.de> <20030625011031.GP26348@holomorphy.com> <200306250325.47529.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306250325.47529.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 03:10, William Lee Irwin III wrote:
>> It severely limits its usefulness. Dropping in a more flexible data
>> structure should be fine.

On Wed, Jun 25, 2003 at 03:25:47AM +0200, Daniel Phillips wrote:
> Eventually it could well make sense to do that, e.g., the radix tree 
> eventually ought to evolve into a btree of extents (probably).  But making 
> things so complex in the first version, thus losing much of the incremental 
> development advantage, would not be smart.  With a single size of page per 
> address_space,  changes to the radix tree code are limited to a couple of 
> lines, for example.
> But perhaps you'd like to supply some examples where more than one size of 
> page in the same address space really matters?

Software-refill TLB architectures would very much like to be handed the
largest physically contiguous chunk of memory out of pagecache possible
and map it out using the fewest number of TLB entries possible. Dropping
in a B+ tree to replace radix trees should be a weekend project at worst.
Speculatively allocating elements that are "as large as sane/possible"
will invariably result in variable-sized elements in the same tree.


-- wli
