Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWBYVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBYVq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBYVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:46:57 -0500
Received: from [192.231.160.6] ([192.231.160.6]:33063 "EHLO cinder.waste.org")
	by vger.kernel.org with ESMTP id S1750778AbWBYVq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:46:56 -0500
Date: Sat, 25 Feb 2006 15:47:04 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225214704.GN13116@waste.org>
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225212247.GC15276@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 09:22:48PM +0000, Russell King wrote:
> init/do_mounts_rd.c:#include "../lib/inflate.c"
> init/initramfs.c:#include "../lib/inflate.c"
> 
> for these your arguments that halting is fine is _NOT_ correct nor is it
> desirable.

If you have an argument for why we shouldn't halt on failed
init{rd,ramfs} decompression, I look forward to hearing it.

> Did you read that post?

This? http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html

"The firmware then calls the kernel decompressor, which dutifully
decompresses the image, and calls the kernel. This image ends up
getting corrupted at some point."

Is your argument that we shouldn't halt after encountering a corrupt
image?

In my mind, being unable to decompress init* is every bit as fatal as
being unable to mount root.

-- 
Mathematics is the supreme nostalgia of our time.
