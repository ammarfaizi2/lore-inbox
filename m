Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWAWIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWAWIsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWAWIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:48:31 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6644 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751441AbWAWIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:48:30 -0500
Date: Mon, 23 Jan 2006 09:47:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] split_page function to split higher order pages?
Message-ID: <20060123084715.GA9241@osiris.boeblingen.de.ibm.com>
References: <20060121124053.GA911@wotan.suse.de> <1137853024.23974.0.camel@laptopd505.fenrus.org> <20060123054927.GA9960@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123054927.GA9960@wotan.suse.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Just wondering what people think of the idea of using a helper
> > > function to split higher order pages instead of doing it manually?
> > 
> > Maybe it's worth documenting that this is for kernel (or even
> > architecture) internal use only and that drivers really shouldn't be
> > doing this..
> 
> I guess it doesn't seem like something drivers would need to use
> (and none appear to do anything like it).

And I thought this could/should be used together with vm_insert_page() that
drivers are supposed to use nowadays instead of remap_pfn_range().
Why shouldn't drivers use this?

Thanks,
Heiko
