Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHAVNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHAVNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWHAVNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:13:31 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46467 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750756AbWHAVNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:13:30 -0400
Date: Tue, 1 Aug 2006 14:14:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>, Gerd Hoffmann <kraxel@suse.de>,
       Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function to a pte range
Message-ID: <20060801211410.GH2654@sequoia.sous-sol.org>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org> <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> - You don't handle huge pages.  For a generic function
>   that sounds like a problem.
> - I believe there is a reason the kernel doesn't already have
>   a function like this.  I seem to recall there being efficiency
>   and fast path arguments.
> - Placing this code in mm/memory.c without a common consumer is
>   pure kernel bloat for everyone who doesn't use this function,
>   which is just about everyone.

We got the opposite feedback the first time we posted this function.
Xen has some users, and I believe there's a couple in-tree functions we could
convert easily w/out overhead issues.  It's generic and this is just the
infrastructure, I think we should leave it.

thanks,
-chris
