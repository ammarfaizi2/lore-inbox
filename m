Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265412AbUEUHct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265412AbUEUHct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUEUHct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:32:49 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:43648
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265412AbUEUHcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:32:09 -0400
Message-ID: <40ADACAB.5070907@redhat.com>
Date: Fri, 21 May 2004 00:15:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040519
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jakub@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
References: <20040520093817.GX30909@devserv.devel.redhat.com>	<20040520155217.7afad53b.akpm@osdl.org>	<40AD9C5E.1020603@redhat.com> <20040520233639.126125ef.akpm@osdl.org>
In-Reply-To: <20040520233639.126125ef.akpm@osdl.org>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> and we're expecting the a's and b's to line up across all architectures and
> compiler options.  I thought that on some architectures that only works out
> if the function has a vararg declaration.

I never heard that.


> Does it do the right thing on stack-grows-up machines?

Would be only HP/PA and I don't see this to be a problem.


> If the compiler passes the first few args via registers and the rest on the
> stack, are we sure that it won't at some level of complexity decide to pass
> _all_ the args on the stack?  It's free to do so, I think.

This is not how the calling conventions are designed.  If registers are
used they happens unconditional of the remainder of the parameter list.
 The stack is used as an overflow.


> I have a vague memory of getting bitten by this trick once...

I don't and, as Ingo mentioned, we already did it before.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
