Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbRDRAn7>; Tue, 17 Apr 2001 20:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDRAnt>; Tue, 17 Apr 2001 20:43:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47615 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132939AbRDRAne>;
	Tue, 17 Apr 2001 20:43:34 -0400
Date: Tue, 17 Apr 2001 20:43:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Golds <jgolds@resilience.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc_lookup not exported
In-Reply-To: <3ADCD8D1.6753B822@resilience.com>
Message-ID: <Pine.GSO.4.21.0104172041330.9930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Apr 2001, Jeff Golds wrote:

> Hi folks.
> 
> I noticed that proc_lookup is not exported in fs/proc/procfs_syms.c but
> that the function is an external in include/linux/proc_fs.h.

Not every public function needs to be exported. proc_lookup() is
shared between different files in fs/proc/, so it can't be made
static. However, it got no business being used outside of the
fs/proc and it certainly shouldn't be used in modules.

