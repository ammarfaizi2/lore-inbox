Return-Path: <linux-kernel-owner+w=401wt.eu-S937553AbWLKSz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937553AbWLKSz1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937550AbWLKSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:55:27 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38250 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937469AbWLKSz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:55:26 -0500
Date: Mon, 11 Dec 2006 19:55:36 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Paul Mackeras <paulus@samba.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andy Whitcroft <apw@shadowen.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211185536.GA19338@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Linus Torvalds wrote:

> Do a
> 
> 	git grep '".*Linux version .*"'
> 
> on the kernel, and see just how CRAP that "get_kernel_version" test is, 
> and has always been.
> 
> But let's hope that CIFS is never compiled into a SLES kernel. Because 
> this isn't worth fixing at that point, and the SLES people should just fix 
> their piece of crap initrd script.

arch/powerpc/boot/wrapper:156:    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \

make $uboot appears to broken as well. I dont have a mkimage here,
so I cant say what it expects. Maybe the wrapper script can use 
'make kernelrelease'

