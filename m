Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUEXSKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUEXSKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEXSKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:10:38 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:50864 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264669AbUEXSKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:10:37 -0400
Date: Mon, 24 May 2004 11:10:32 -0700
Message-Id: <200405241810.i4OIAWDO007750@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus sigaltstack calls by rt_sigreturn
In-Reply-To: Andi Kleen's message of  Sunday, 23 May 2004 14:29:24 +0200 <m38yfjtjh7.fsf@averell.firstfloor.org>
X-Zippy-Says: Disco oil bussing will create a throbbing naugahide pipeline
   running straight to the tropics from the rug producing regions and
   devalue the dollar!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath <roland@redhat.com> writes:
> 
> > There is a longstanding bug in the rt_sigreturn system call.
> > This exists in both 2.4 and 2.6, and for almost every platform.
> 
> I don't think the patch is really needed on x86-64 because the
> kernel address should always return -EFAULT in access_ok().

The patch I sent doesn't just avoid the bogus access, it implements the
feature properly.
