Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUKKB3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUKKB3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKKB3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:29:47 -0500
Received: from holomorphy.com ([207.189.100.168]:3727 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262073AbUKKB3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:29:25 -0500
Date: Wed, 10 Nov 2004 17:29:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-ID: <20041111012919.GD3217@holomorphy.com>
References: <1100135825.7402.32.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100135825.7402.32.camel@desktop.cunninghams>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 12:17:05PM +1100, Nigel Cunningham wrote:
> That oops in kunmap got me thinking of my recent DEBUG_HIGHMEM
> additions, so I want for a walk through the -mm4 patch, and found plenty
> of instances of people making the same mistake I did... using the struct
> page * in the call to kunmap, rather than the virtual address.
> I guess the best way to handle it is find/notify the respective authors
> of patches in the tree? The problems are in:
> Reiser4 (lots)
> CacheFS (lots)
> afs
> binfmt_elf
> libata_core
> (I'm hoping some of the above people will see this message and save me
> some effort :>)

That only applies to kunmap_atomic(); kunmap()'s argument should be a page.


-- wli
