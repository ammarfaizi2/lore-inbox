Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKZDJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKZDJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVKZDJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:09:23 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:42969 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932462AbVKZDJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:09:23 -0500
Date: Sat, 26 Nov 2005 11:17:55 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
Message-ID: <20051126031755.GA7226@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20051125151210.993109000@localhost.localdomain> <20051125164317.c42c0639.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125164317.c42c0639.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 04:43:17PM +0100, Diego Calleja wrote:
> Recently, a openoffice hacker wrote in his blog that the kernel was
> culprit of applications not starting as fast as in other systems.
> Most of the reasons he gave were wrong, but there was a interesting
> one: When you start your system, you've lots of free memory. Since
> you have lots of memory, he said it was reasonable to expect that
> kernel would readahead *heavily* everything it can to fill that
> memory as soon as possible (hoping that what you readahead'ed was
> part of the kde/gnome/openoffice libraries etc) and go back to the
> normal behaviour when your free memory is used by caches etc.
> "Teorically" it looks like a nice heuristic for desktops. Does
> adaptative readahead does something like this?

It's interesting ;)
In fact some distributions do have a read-ahead script to preload files on
startup. The readahead system call should be enough for this purpose:

NAME
       readahead - perform file readahead into page cache

SYNOPSIS
       #include <fcntl.h>

       ssize_t readahead(int fd, off64_t *offset, size_t count);

Thanks,
Wu
