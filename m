Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWHTKRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHTKRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWHTKRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:17:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55758 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWHTKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:17:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Nx6fxkU8tCKLoqdkxKYFGha/rX6/r84LNN4tiPLhVwkSbQwhxg8KfTaTWcpHldDqLpJc5Bpo34lrVvWJxYQuiHxNScG+ScDiE9tudzFdzJmBdmMabpDfdlEhXoNbw2+lHb+663p6VUfLsB2hFacQLJzBB6WuWhx02WnvIcqVZEo=
Date: Sun, 20 Aug 2006 12:17:06 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       airlied@linux.ie
Subject: Re: [mm patch] drm, minor fixes
Message-ID: <20060820121706.GG720@slug>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060819231621.GF720@slug> <1156066626.23756.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156066626.23756.3.camel@laptopd505.fenrus.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 11:37:06AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-08-19 at 23:16 +0000, Frederik Deweerdt wrote:
> > On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > > 
> > Hi Andrew,
> > 
> > The following patch adds minor fixes to the drm code:
> > - fix return values that are wrong (return E* instead of return -E*)
> 
> are you sure the callers of these don't wrap it inside a DRM_ERR()
> macro ?
I changed the values when:
- I've checked what seemed right, getting back to the system call.
  drm_ioctl(), through a call to func().
  That's the case for:
  - the EFAULT value in i915_emit_box
  - two EINVAL values in drm_setversion
- the return value wasn't used. That was the case for
  drm_set_busid return values, I felt having returned values negative
  from the start was more consistent.

Is there a particular change that looked suspicious to you?
Thanks,
Frederik
