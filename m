Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWKDADS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWKDADS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWKDADR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:03:17 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:60108 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932510AbWKDADR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:03:17 -0500
Date: Fri, 3 Nov 2006 18:57:22 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: remove IOPL check on task switch
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200611031900_MC3-1-D041-6F32@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <454B850C.3050402@vmware.com>

On Fri, 03 Nov 2006 10:06:04 -0800, Zachary Amsden wrote:

> Chuck Ebbert wrote:
> > IOPL is implicitly saved and restored on task switch,
> > so explicit check is no longer needed.
> 
> Nack.  This is used for paravirt-ops kernels that use IOPL'd userspace.  

How does that work?  In the stock kernel, anything done by
the call to set_iopl_mask() (that was removed by the patch)
will be nullified by the 'popfl' at the end of the switch_to()
macro.

-- 
Chuck
"Even supernovas have their duller moments."
