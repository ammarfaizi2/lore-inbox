Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTENXUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTENXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:20:34 -0400
Received: from fmr01.intel.com ([192.55.52.18]:34030 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263150AbTENXUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:20:32 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB0A70@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Christopher Hoover'" <ch@murgatroid.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
Date: Wed, 14 May 2003 16:33:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Christopher Hoover [mailto:ch@murgatroid.com]
> 
> On Wed, May 14, 2003 at 07:14:46AM +0100, Christoph Hellwig wrote:
> > On Tue, May 13, 2003 at 09:32:07PM -0700, Christopher Hoover wrote:
> > > Not everyone needs futex support, so it should be optional.  This is
> > > needed for small platforms.
> >
> > Looks good.  I think you want to disable it unconditionally for
!CONFIG_MMU.
> 
> Good point.
> 
> Here it is again with the config change.  The previous version also had
> had a Makefile typo.  Plus a cond_syscall for compat_sys_futex to make
> it work for CONFIG_COMPAT (untested), as pointed out by akpm.

How does this affect mm_release() in fork.c? there is a call to sys_futex();
if you make it conditional, will it break anything in there?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
