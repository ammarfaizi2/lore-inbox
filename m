Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUGORTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUGORTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUGORTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:19:15 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:22029 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266252AbUGORTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:19:13 -0400
Date: Thu, 15 Jul 2004 19:19:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Paul Jakma <paul@clubi.ie>
Cc: Arjan van de Ven <arjanv@redhat.com>, christophe.varoqui@free.fr,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: namespaces (was Re: [Q] don't allow tmpfs to page out)
Message-ID: <20040715171909.GA5518@pclin040.win.tue.nl>
References: <1089878317.40f6392d7e365@imp5-q.free.fr> <20040715080017.GB20889@devserv.devel.redhat.com> <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 01:31:08PM +0100, Paul Jakma wrote:

> speaking of which, how does one use namespaces exactly? The kernel 
> appears to maintain mount information per process, but how do you set 
> this up?
> 
> neither 'man mount/namespace' nor 'appropos namespace' show up 
> anything.

Try "man 2 clone" and look for CLONE_NEWNS.

Somewhere else I wrote

  Since 2.4.19/2.5.2, the clone() system call, a generalization of
  Unix fork() and BSD vfork(), may have the CLONE_NEWNS flag, that
  says that all mount information must be copied. Afterwards, mount,
  chroot, pivotroot and similar namespace changing calls done by this
  new process do influence this process and its children, but not other
  processes. In particular, the virtual file /proc/mounts that lists the
  mounted filesystems, is now a symlink to /proc/self/mounts - different
  processes may live in entirely different file hierarchies.

Andries

