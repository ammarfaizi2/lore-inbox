Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLHS2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLHS2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:28:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:32156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbTLHS1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:27:41 -0500
Date: Mon, 8 Dec 2003 10:26:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
Cc: liangbin01@iscas.cn, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: PROBLEM: A Capability LSM Module serious bug
Message-ID: <20031208102659.B10325@osdlab.pdx.osdl.net>
References: <20031207121151.22328.qmail@abyss.iscas.cn> <20031208150809.GA14068@escher.cs.wm.edu> <20031208163618.8789.qmail@abyss.iscas.cn> <20031208164854.GA15146@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031208164854.GA15146@escher.cs.wm.edu>; from hallyn@CS.WM.EDU on Mon, Dec 08, 2003 at 11:48:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (hallyn@CS.WM.EDU) wrote:
> The main question is do we declare cap_effective to belong solely to
> capability.c, or do we want capability.c to trust previous LSM's
> computations of those values?  So, even with the current case, if we
> insmod, rmmod, then re-insmod capability, do we want to revoke all
> previous cap_* computations?

This is a common issue with the opaque blobs as well.

> It seems reasonable for it "belong" to capability.c (and I've heard of
> noone else wanting to use it).  I just don't think we've explicitly
> declared this to be the case.

Unfortunately, it's currently used by kernel proper.  So we need a
generic solution.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
