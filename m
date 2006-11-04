Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWKDADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWKDADq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWKDADp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:03:45 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:48515 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932508AbWKDADo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:03:44 -0500
Date: Fri, 3 Nov 2006 19:00:11 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: remove IOPL check on task switch
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200611031902_MC3-1-D042-CA1E@compuserve.com>
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
