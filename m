Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTKLQxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKLQxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:53:40 -0500
Received: from ns.suse.de ([195.135.220.2]:10134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263828AbTKLQxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:53:34 -0500
Date: Wed, 12 Nov 2003 17:53:33 +0100
From: Michael Schroeder <mls@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 early userspace init
Message-ID: <20031112165333.GA31882@suse.de>
References: <20031112115021.GA24875@suse.de> <1068655518.14435.37.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068655518.14435.37.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 2048G/BBC5057B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 08:45:19AM -0800, Bryan O'Sullivan wrote:
> On Wed, 2003-11-12 at 03:50, Michael Schroeder wrote:
> 
> > how about adding something like this to init/do_mounts.c?
> 
> It's not a bad idea, but surely you should be using the init= boot
> parameter instead of hard-coding a path.

I'm not so sure about this. One can argue that the init= parameter
should be evaluated by kinit when calling the real init.

> In any case, I don't think you should expect a patch to be accepted. 
> There's not much point in further crufting up do_mounts.c in generic
> kernels during 2.6, until do_mounts moves completely out of the kernel. 
> Some people are happy enough with root=0:0, so there's not obviously a
> consensus about which stopgap measure will do for now.

Well, root=0:0 also needs a kernel patch and has the disadvantage
that one cannot specify the desired root as a boot option.

The point is that it is impossible to use initramfs as a
initrd replacement with the current code (2.6-test9), so one 
of the patches should go in, either the 0:0 patch or my patch.

Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
