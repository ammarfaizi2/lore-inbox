Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUIIXgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUIIXgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIIXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:33:48 -0400
Received: from ozlabs.org ([203.10.76.45]:53193 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266867AbUIIXdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:33:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16704.59444.785268.367031@cargo.ozlabs.ibm.com>
Date: Fri, 10 Sep 2004 09:33:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: anton@au.bim.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH Trivial] ppc64:  Use STACK_FRAME_OVERHEAD macro in misc.S
In-Reply-To: <1094772116.16444.81.camel@67-41-71-119.roch.qwest.net>
References: <1094772116.16444.81.camel@67-41-71-119.roch.qwest.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Boyer writes:

> I found a couple places where a hardcoded value for the stack frame was
> used instead of the STACK_FRAME_OVERHEAD macro.  The following patch
> fixes that.

Using STACK_FRAME_OVERHEAD here would be purely arbitrary (i.e. the
112 here has no connection with the stack frames established in head.S
and entry.S).  This function needs a stack frame and 112 bytes is the
minimum size specified by the ABI.  I think it's quite clear as it is.

Paul.
