Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271366AbUJVPPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271366AbUJVPPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271364AbUJVPPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:15:51 -0400
Received: from holomorphy.com ([207.189.100.168]:47811 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271359AbUJVPN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:13:59 -0400
Date: Fri, 22 Oct 2004 08:13:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make drivers/char/mem.c use remap_pfn_range()
Message-ID: <20041022151354.GX17038@holomorphy.com>
References: <200410220206.i9M26gUi016689@hera.kernel.org> <20041022021908.GI17038@holomorphy.com> <Pine.LNX.4.58.0410220720220.2101@ppc970.osdl.org> <20041022143714.GT17038@holomorphy.com> <Pine.LNX.4.58.0410220807430.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410220807430.2101@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:
>> What I posted shifted the correct argument, though vma->vm_pgoff would
>> have been been better, as it shifted offset right by PAGE_SHIFT, where
>> offset could have overflowed. I have no idea what you're referring to
>> about shifting the wrong argument.

On Fri, Oct 22, 2004 at 08:09:07AM -0700, Linus Torvalds wrote:
> Ok, that patch just got lost.
> Quite as well, actually. The whole point of changing remap_page_range() to 
> remap_pfn_range() is to give the full range of page frame numbers, and 
> just shifting "offset" back down thus seems to be a bug to me. Otherwise 
> we migth as well just have continued with the old code.

What I had intended to be the functional improvements were in the arch
code for pci_mmap_page_range(), but I would say the mem.c change beyond
my own changes is an improvement. All is well.


-- wli
