Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUBFB57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUBFB57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:57:59 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:42370 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S265339AbUBFB54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:57:56 -0500
Date: Thu, 5 Feb 2004 19:57:55 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Greg KH <greg@kroah.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, sean.hefty@intel.com,
       linux-kernel@vger.kernel.org, woody@co.intel.com, bill.magro@intel.com,
       woody@jf.intel.com, infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040206015754.GQ11222@kalmia.hozed.org>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96F2@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96F2@mercury.infiniconsys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 05:02:30PM -0500, Tillier, Fabian wrote:
> That is absolutely correct.  In addition to portability between kernel
> versions and operating systems, there is also portability between
> user-mode and kernel-mode within a single release.


This is another issue... I think we should have a mechanism to allow
user code to call functions in user mode that are exported by the
kernel. Like the gettimeofday() syscall bypass stuff which I have heard
about but can't remember the details of.

The linux kernel obviously knows exactly what kind of processor it is
running on, and should be able to know exactly what the best memcpy()
function is. This should be exported to userspace instead of depending
on glibc to ask the kernel what cpu it has, and hope glibc has
reasonably optimized code. 

The same interface would quite easily solve the infiniband atomic
locking issues.

Anyone in the infiniband industry please take note, we probably should 
have had this discussion a year ago, and remember this next time.

