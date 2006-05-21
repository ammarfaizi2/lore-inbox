Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWEUOLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWEUOLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWEUOLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:11:05 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:37580 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964880AbWEUOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:11:04 -0400
Subject: Re: [patch] i386, vdso=[0|1] boot option and
	/proc/sys/vm/vdso_enabled
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       kraxel@suse.de, zach@vmware.com
In-Reply-To: <20060520022650.46b048f8.akpm@osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
	 <20060516064723.GA14121@elte.hu>
	 <1147852189.1749.28.camel@localhost.localdomain>
	 <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu>
	 <20060519181125.5c8e109e.akpm@osdl.org>
	 <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	 <20060520085351.GA28716@elte.hu>  <20060520022650.46b048f8.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 21 May 2006 16:10:51 +0200
Message-Id: <1148220651.3902.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-20 at 02:26 -0700, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > 
> > * Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > > Well that patch took a machine from working to non-working.  Pretty serious
> > > > stuff.  We should get to the bottom of the problem so we can assess the
> > > > risk and impact, no?
> > > 
> > > Yes. And it would be good to have a way to turn it off - either 
> > > globally of by some per-process setup (eg off by default, but turn on 
> > > when doing some magic).
> > > 
> > > The per-process one would be the harder one, because it would require 
> > > the fixmap entry, but not globally. So I suspect the only practical 
> > > thing would be to have it be a kernel boot-time option.
> > 
> > below is a patch that adds the vdso=0 boot option from exec-shield and 
> > the /proc/sys/vm/vdso_enabled per-system sysctl.
> > 
> > Andrew, could you try this - do newly started processes work fine if you 
> > re-enable the vdso after booting with vdso=0?
> 
> vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled 
> vmm:/home/akpm# 
> vmm:/home/akpm> ls -l
> zsh: segmentation fault  ls -l

any chance to get a coredump ?


