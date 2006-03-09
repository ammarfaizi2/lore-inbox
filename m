Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWCIJgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWCIJgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWCIJgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:36:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751714AbWCIJgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:36:02 -0500
Date: Thu, 9 Mar 2006 10:35:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       mmlnx@us.ibm.com
Subject: Re: [PATCH] fix kexec asm
Message-ID: <20060309093551.GA2830@elf.ucw.cz>
References: <200603072135.16116.mason@suse.com> <m1zmk1y3j1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1zmk1y3j1.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 07-03-06 21:16:34, Eric W. Biederman wrote:
> Chris Mason <mason@suse.com> writes:
> 
> > From: Michael Matz <matz@suse.de>
> >
> > While testing kexec and kdump we hit problems where the new kernel would
> > freeze or instantly reboot.  The easiest way to trigger it was to kexec a
> > kernel compiled for CONFIG_M586 on an athlon cpu.  Compiling
> > for CONFIG_MK7 instead would work fine.
> >
> > The patch below fixes a few problems with the kexec inline asm.
> 
> Thanks.  Specifying the stomp of %eax in load_segments is definitely
> good.  The memory stomp looks excessive and if this was a fast path
> I would worry about it.  As it is better safe than sorry.

Why excessive? It reloads %ss, AFAICS; at that point, all the stack
potentially changes from gcc's POV.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
