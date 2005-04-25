Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDYXS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDYXS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVDYXS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:18:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:39893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbVDYXSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:18:23 -0400
Date: Mon, 25 Apr 2005 16:17:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: robert.j.woodruff@intel.com, arlin.r.davis@intel.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbsimplementation
Message-Id: <20050425161747.28b03800.akpm@osdl.org>
In-Reply-To: <426D797D.3000108@ammasso.com>
References: <ORSMSX408FRaqbC8wSA00000014@orsmsx408.amr.corp.intel.com>
	<426D797D.3000108@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Bob Woodruff wrote:
> 
> > There definitely needs to be a mechanism to prevent people from pinning
> > too much memory. 
> 
> Any limit would have to be very high - definitely more than just half.  What if the 
> application needs to pin 2GB?  The customer is not going to buy 4+ GB of RAM just because 
> Linux doesn't like pinning more than half.  In an x86-32 system, that would required PAE 
> support and slow everything down.
> 
> Off the top of my head, I'd say Linux would need to allow all but 512MB to be pinned.  So 
> you have 3GB of RAM, Linux should allow you to pin 2.5GB.
> 

You can pin the whole darn lot *if you have the correct privileges*.
