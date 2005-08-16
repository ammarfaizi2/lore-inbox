Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVHPXpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVHPXpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVHPXpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:26758 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750737AbVHPXpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:45:24 -0400
Date: Wed, 17 Aug 2005 01:45:14 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in desc
Message-ID: <20050816234514.GG27628@wotan.suse.de>
References: <200508110454.j7B4sBDK019538@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110454.j7B4sBDK019538@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:54:11PM -0700, zach@vmware.com wrote:
> Use an early clobber on addr to avoid the extra rorl instruction at the
> end of _set_tssldt_desc.

I would suggest to just use C for this. I do this on x86-64 and 
I don't think there is any reason to use this hard to maintain
code for it.

It's probably a left over from Linus first experiments with inline
assembly, similar to the old string.h and by now so obsolete
it doesn't even stink anymore.

-Andi
