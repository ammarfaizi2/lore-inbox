Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVLHA4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVLHA4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLHA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:56:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965079AbVLHA4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:56:44 -0500
Date: Wed, 7 Dec 2005 16:58:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
Message-Id: <20051207165800.7f6908df.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512071641080.26288@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
	<43976FD4.8060404@cyberone.com.au>
	<Pine.LNX.4.62.0512071641080.26288@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Thu, 8 Dec 2005, Nick Piggin wrote:
> 
> > Do we need a lock_cpu_hotplug() around here?
> 
> Well, then we may need that lock for each "for_each_online_cpu" use?
>

I suppose so..

> > Can't this deadlock if 2 CPUs each send work to the other
> 
> Then we would need to fix the workqueue flushing function.

I don't think I can see a deadlock here.
