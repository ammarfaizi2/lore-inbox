Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUH1Nvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUH1Nvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUH1Nvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:51:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:22482 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266825AbUH1Nvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:51:43 -0400
Date: Sat, 28 Aug 2004 15:48:33 +0200
From: Andi Kleen <ak@suse.de>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 compile error in 2.6.9-rc1-bk1
Message-Id: <20040828154833.3d9aa7d7.ak@suse.de>
In-Reply-To: <1093460094.23633.18.camel@duffman>
References: <1093460094.23633.18.camel@duffman>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 11:54:54 -0700
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> wrote:

> If you have CONFIG_SWIOTLB=y (GART_IOMMU=y), you get:
> 
> ld: BFD 2.15.90.0.3 20040415 assertion fail ../../bfd/linker.c:619
> arch/x86_64/mm/built-in.o(.init.text+0x52a): In function `mem_init':
> : undefined reference to `swiotlb_force'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [_all] Error 2
> 
> This was added in Linus's tree.  But I cannot find where swiotlb_force is defined...

It is defined in a ia64 specific file (believe it or not) The change should 
go in as soon as Linus pulls the IA64 update from Tony Luck. 

For now you can just comment out the if. 

-Andi
