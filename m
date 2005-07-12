Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVGLKYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVGLKYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVGLKWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:22:17 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:2751 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261311AbVGLKWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:22:06 -0400
To: ncunningham@cyclades.com
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12: 301-proc-acpi-sleep-activate-hook.patch
In-Reply-To: <1121162866.13869.142.camel@localhost>
References: <11206164393426@foobar.com> <11206164393081@foobar.com> <20050710230347.GB513@infradead.org> <20050710230347.GB513@infradead.org> <1121150703.13869.27.camel@localhost> <E1DsHMp-00062f-00@chiark.greenend.org.uk> <E1DsHMp-00062f-00@chiark.greenend.org.uk> <1121162866.13869.142.camel@localhost>
Date: Tue, 12 Jul 2005 11:22:03 +0100
Message-Id: <E1DsHtr-0001ly-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
> On Tue, 2005-07-12 at 19:47, Matthew Garrett wrote:
>> In general, the kernel does very little to prevent users from shooting
>> themselves in the foot (or even chainsawing off their arms). We can do
>> these checks in userspace rather than adding more kernel code.
> 
> Just because the kernel does very little, that doesn't mean it should.
> Particularly for something like suspend to disk, where it's not just a
> matter of an oops but of potential hard disk corruption, this is
> important.

The kernel isn't there to protect people. It's there to provide
functionality.
 
> If I could do it in userspace, I would. The trouble is, the userspace
> app may not be there to tell the user what is happening, and this might
> be part of the problem.

You're suggesting that users who are technically competent to compile
their own kernel and write their own initrd scripts are unable to deal
with checking whether or not a filesystem is mounted? You don't need an
application to do that, it's a simple matter of shell scripting. And, in
almost every case, if something is a simple matter of shell scripting it
shouldn't be in the kernel.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
