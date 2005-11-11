Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVKKSf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVKKSf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVKKSf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:35:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750995AbVKKSf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:35:26 -0500
Date: Fri, 11 Nov 2005 10:35:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Wright <chrisw@osdl.org>, Avi Kivity <avi@argo.co.il>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
Message-ID: <20051111183512.GV5856@shell0.pdx.osdl.net>
References: <43737CBE.2030005@argo.co.il> <20051111084554.GZ7991@shell0.pdx.osdl.net> <1131718887.8805.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131718887.8805.33.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> Bruce has a simpler patch (see attachment). The call to fasync_helper()
> in order to free active structures will have already been done in
> locks_delete_lock(), so in principle, all we want to do is to skip the
> fasync_helper() call in fcntl_setlease().

Yes, that's better, thanks.  Will you make sure it gets to Linus?

thanks,
-chris
