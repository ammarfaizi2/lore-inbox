Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbUKDWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUKDWoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUKDWno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:43:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:19937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262481AbUKDWm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:42:59 -0500
Date: Thu, 4 Nov 2004 14:42:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [2/6] LSM Stacking: Add stacker LSM
Message-ID: <20041104144258.A2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609681.2096.16.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099609681.2096.16.camel@serge.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 05:08:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge Hallyn (serue@us.ibm.com) wrote:
> This patch adds the stacker module, still required in order to
> stack several LSMs.  In order to use this with SELinux, it must be
> compiled into the kernel.  Otherwise, it can be loaded as a module.

all the stacker_rwsem business has got to go.  can't you make the same
array assumptions as the blobs, and assign modules to slots?  also the
sysfs stuff should go into a (not quite yet) existing subsystem.  i'm
not positive the authoritative capable() hook logic is right.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
