Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVBYRLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVBYRLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVBYRLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:11:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:59058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262752AbVBYRL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:11:28 -0500
Date: Fri, 25 Feb 2005 09:11:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vm: mlock superfluous variable
Message-ID: <20050225171122.GE28536@shell0.pdx.osdl.net>
References: <421E74B5.3040701@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E74B5.3040701@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Darren Hart (dvhltc@us.ibm.com) wrote:
> The were a couple long standing (since at least 2.4.21) superfluous 
> variables and two unnecessary assignments in do_mlock().  The intent of 
> the resulting code is also more obvious.
> 
> Tested on a 4 way x86 box running a simple mlock test program.  No 
> problems detected.

Did you test with multiple page ranges, and locking subsets of vmas?
Seems that splitting could cause a problem since you now sample vm_end
before and after fixup, where the vma could be changed in the middle.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
