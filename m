Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUE0Rni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUE0Rni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUE0Rnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:43:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:38608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264916AbUE0Rne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:43:34 -0400
Date: Thu, 27 May 2004 10:43:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
Message-ID: <20040527104332.Q22989@build.pdx.osdl.net>
References: <1085679127.2070.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1085679127.2070.21.camel@localhost.localdomain>; from fabian.frederick@skynet.be on Thu, May 27, 2004 at 07:32:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* FabF (fabian.frederick@skynet.be) wrote:
> Andrew,
> 
> 	Here's a patch to have standard __put_user for integer transfers in lp
> driver.Is it correct ?

No, you've removed the security check but using __put_user.  put_user
maintains the access_ok() check.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
