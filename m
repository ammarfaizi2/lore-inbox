Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUKKBex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUKKBex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUKKBew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:34:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:34192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262073AbUKKBev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:34:51 -0500
Date: Wed, 10 Nov 2004 17:34:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-ID: <20041110173450.O14339@build.pdx.osdl.net>
References: <1100135825.7402.32.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1100135825.7402.32.camel@desktop.cunninghams>; from ncunningham@linuxmail.org on Thu, Nov 11, 2004 at 12:17:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nigel Cunningham (ncunningham@linuxmail.org) wrote:
> Hi Andrew et al.
> 
> That oops in kunmap got me thinking of my recent DEBUG_HIGHMEM
> additions, so I want for a walk through the -mm4 patch, and found plenty
> of instances of people making the same mistake I did... using the struct
> page * in the call to kunmap, rather than the virtual address.
> 
> I guess the best way to handle it is find/notify the respective authors
> of patches in the tree? The problems are in:
> 
> Reiser4 (lots)
> CacheFS (lots)
> afs
> binfmt_elf
> libata_core

I think you are confusing with kunmap_atomic?

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
