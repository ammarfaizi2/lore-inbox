Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbULQSse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbULQSse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbULQSsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:48:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:11483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262117AbULQSn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:43:58 -0500
Date: Fri, 17 Dec 2004 10:43:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] fork historic module
Message-ID: <20041217104355.A469@build.pdx.osdl.net>
References: <a482d6bf04121708146f221b15@mail.gmail.com> <Xine.LNX.4.44.0412171134220.14531-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0412171134220.14531-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Fri, Dec 17, 2004 at 11:40:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> 
> > Any comments and suggestions are welcome.
> 
> I don't see why you are using LSM for this.
> 
> It's not an access control system, only uses one LSM hook (I gather
> becuase it happens to be in the right place), and furthermore, uses a hook
> intended for LSM resource management.

We went through this before.  I recommended against using it, and
suggested using proper framework, such as PAGG or CKRM.  However,
Guillaume preferred to use something that was in the kernel instead of
relying on another external patch.  I don't have a problem with that,
but it's not mergeable.  Ideally efforts would be made to consolidate to
common resource management needs, and elsa could be part of this effort.
So Guillame, feel free to use the LSM hook, but just know it's not a
mergeable work.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
