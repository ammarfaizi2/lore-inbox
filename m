Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945953AbWBOOJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945953AbWBOOJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWBOOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:09:45 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29332 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945953AbWBOOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:09:44 -0500
Date: Wed, 15 Feb 2006 09:09:36 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
In-Reply-To: <20060215130734.GA5590@lst.de>
Message-ID: <Pine.LNX.4.58.0602150903020.25659@gandalf.stny.rr.com>
References: <20060215130734.GA5590@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2006, Christoph Hellwig wrote:

> Drivers have no business looking at the task list and thus using this
> lock.  The only possibly modular users left are:
>
>  arch/ia64/kernel/mca.c
>  drivers/edac/edac_mc.c
>  fs/binfmt_elf.c
>
> which I'll send out fixes for soon.
>

Hmm, I have some debug modules that do use that lock.  Is it possible to
export it only if CONFIG_DEBUG_KERNEL?  If this isn't proper either, it's
no big deal. I'll just make a patch that exports it, and add it to my
kernel before debugging.  I'm just asking to make my life more convenient
:-)

-- Steve

