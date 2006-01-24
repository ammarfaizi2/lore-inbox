Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWAXJHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWAXJHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWAXJHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:07:00 -0500
Received: from mail.suse.de ([195.135.220.2]:59067 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030392AbWAXJG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:06:59 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 0/9] Shared ia32 syscall table
Date: Tue, 24 Jan 2006 10:02:42 +0100
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200601240355_MC3-1-B687-9FD3@compuserve.com>
In-Reply-To: <200601240355_MC3-1-B687-9FD3@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241002.43408.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 09:53, Chuck Ebbert wrote:
> In-Reply-To: <200601240141.08152.ak@suse.de>
> 
> On Tue, 24 Jan 2006 at 01:41:07 +0100, Andi Kleen wrote:
> 
> > On Tuesday 24 January 2006 01:36, Chuck Ebbert wrote:
> > > This patch series updates i386 and x86_64 so they share
> > > the same ia32 syscall table.  UML already uses the i386
> > > table and is updated to use the new shared table as well.
> > 
> > That's wrong for x86-64. The IA32 syscall table needs
> > to point to compat_* version of syscalls, while the native
> > IA32 table uses sys_* directly.
> 
> How could I have possibly gotten a successful boot of an i386
> distro on top of the patched x86_64 kernel if this were wrong?
> 
> Did you even look at the patches?

No, because they arrived more than an hour after the initial
description and i just replied to that.

Looking at the patch I must say I prefer the old straight
table over your #define mess.

-Andi
