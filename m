Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUFFIKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUFFIKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFFIKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:10:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:59327 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263032AbUFFIKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:10:22 -0400
Date: Sun, 6 Jun 2004 09:10:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike McCormack <mike@codeweavers.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040606081021.GA6463@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C2E045.8090708@codeweavers.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 06:13:41PM +0900, Mike McCormack wrote:
> We are using our own user space loader now, but a kernel space loader is 
>  neither portable or practical.

Huh?  binfmts do work on all linux architectures unchanged.  What you do
on other operating systems is up to you.  And btw, netbsd already has
binfmt_pecoff, you could certainly make use of that, too.

> it would be 
> nice if somebody let us know when they're going to make a change that is 
> going to break Wine, and provide a way for us to workaround that change, 
> or even better maintain real binary compatability...

_You_ are relying on undocumented assumptions here.   Windows has different
address space layouts than ELF ABI systems and I think you're much better
off having your own pecoff loader for that.

> It seems Linus's kernel does that quite well, but some vendors seem not 
> to care too much about breaking Wine.

Why should they?  You need to fix up the broken assumptions in wine.
