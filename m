Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWCAI1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWCAI1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 03:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCAI1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 03:27:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932186AbWCAI1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 03:27:42 -0500
Date: Wed, 1 Mar 2006 00:26:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: pj@sgi.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301002631.48e3800e.akpm@osdl.org>
In-Reply-To: <20060228234807.55f1b25f.pj@sgi.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > I am seeing as a separate bug the crash during boot that I reported
> > last, when I turned on some DEBUG options. 
> 
> I have narrowed it down to between the following two patches
> in *-mm (patch numbers 20 and 90 in 2.6.16-rc5-mm1, roughly):

I hope that machine doesn't take too long to boot.

>     multiple-exports-of-strpbrk.patch == ok
>     git-drm.patch == bad

That would point at either the sysfs changes in gregkh-driver-* or acpi. 
There have been no changes in the acpi patch in a couple of weeks.  Did
that machine run rc4-mm2?

> ip is at sysfs_create_group+0x30/0x2a0

It does have a sysfsy feel.  But I don't immediately see how any of the
patches in the driver tree can affect this.
