Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVEBQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVEBQx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEBQmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:42:35 -0400
Received: from mail.suse.de ([195.135.220.2]:42678 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261475AbVEBQkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:40:07 -0400
Date: Mon, 2 May 2005 18:40:01 +0200
From: Andi Kleen <ak@suse.de>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, ak@suse.de
Subject: Re: [patch 1/1] Uml: kludgy compilation fixes for x86-64 subarch modules support [for -mm]
Message-ID: <20050502164001.GF7342@wotan.suse.de>
References: <20050501184515.F1AA48D835@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501184515.F1AA48D835@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 08:45:15PM +0200, blaisorblade@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Cc: Andi Kleen <ak@suse.de>
> 
> These are some trivial fixes for the x86-64 subarch module support. The only
> potential problem is that I have to modify arch/x86_64/kernel/module.c, to
> avoid copying the whole of it.
> 
> I can't use it verbatim because it depends on a special vmalloc-like area for
> modules, which for now (maybe that's to fix, I guess not) UML/x86-64 has not.
> I went the easy way and reused the i386 vmalloc()-based allocator.

Patch is ok for me. Another way would have been to use __attribute__((weak)),
but I guess the ifdef is ok too.

-Andi

