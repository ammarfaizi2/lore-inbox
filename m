Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUDPWTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbUDPWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:17:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:16829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263901AbUDPWMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:12:50 -0400
Date: Fri, 16 Apr 2004 15:12:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Wright <chrisw@osdl.org>, Ken Ashcraft <ken@coverity.com>,
       linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       scott.feldman@intel.com, Ganesh.Venkatesan@intel.com,
       john.ronciak@intel.com, cramerj@intel.com, shemminger@osdl.org
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416151236.T21045@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int> <20040416112051.V22989@build.pdx.osdl.net> <408031E2.6040407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <408031E2.6040407@pobox.com>; from jgarzik@pobox.com on Fri, Apr 16, 2004 at 03:20:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> The proper solution is for e1000 to use ethtool_ops.

I think Steve Hemminger is cobbling something together ATM.  Note that a
mechnical switchover would have ->get_regs_len() return 32 (ints), while it
only fills in 26, leaking those last 24 bytes.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
