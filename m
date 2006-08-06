Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWHFBMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWHFBMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWHFBMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 21:12:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932684AbWHFBMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 21:12:19 -0400
Date: Sat, 5 Aug 2006 18:12:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: davej@redhat.com, torvalds@osdl.org, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
 /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-Id: <20060805181208.ec8ff3f0.akpm@osdl.org>
In-Reply-To: <20060805004600.2e63fcd9.akpm@osdl.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	<Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	<20060804222400.GC18792@redhat.com>
	<20060805003142.GH18792@redhat.com>
	<20060805021051.GA13393@redhat.com>
	<20060805022356.GC13393@redhat.com>
	<20060805024947.GE13393@redhat.com>
	<20060805064727.GF13393@redhat.com>
	<20060805004600.2e63fcd9.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006 00:46:00 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Sat, 5 Aug 2006 02:47:28 -0400
> Dave Jones <davej@redhat.com> wrote:
> 
> > Creating a variant of __create_workqueue that doesn't take the lock
> > seems really nasty.
> 
> Honestly, the default fix for lock_cpu_hotplug() problems should be to
> delete the lock_cpu_hotplug() calls and to implement local locking.
> 
> Here's a not-runtime-tested workqueue.c example.

It's now slightly-runtime-tested.  I'll include it in rc3-mm1.
