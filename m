Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUCMSFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUCMSFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:05:18 -0500
Received: from ns.suse.de ([195.135.220.2]:45489 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263151AbUCMSFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:05:09 -0500
Date: Sat, 13 Mar 2004 19:05:06 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, davem@redhat.com, sparclinux@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org, gniibe@m17n.org, kkojima@rr.iij4u.or.jp,
       linux-sh@m17n.org
Subject: Re: modular nfsd requires kernel changes on sh, sparc64, x86_64
Message-ID: <20040313180505.GA2338@wotan.suse.de>
References: <20040313173444.GX14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313173444.GX14833@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 06:34:44PM +0100, Adrian Bunk wrote:
> Compiling and inserting a module into the currently running kernel 
> should work without needing a reboot.
> 
> For nfsd this seems to work everywhere except on the sh, sparc64 
> and x86_64 architectures where adding the nfsd module changes 
> non-modular kernel code (checked in 2.6.4-mm1):

Ideally if you want to do that I would suggest you move the nfsd
emulation layer into nfsd itself (compat_nfsservctl) and let
it be called using a stub like the normal modular sys_nfsservctl

-Andi
