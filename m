Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTHGQBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHGQAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:00:10 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:6280 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S270325AbTHGP5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:57:07 -0400
Date: Thu, 7 Aug 2003 16:57:19 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
In-Reply-To: <1060264715.3169.51.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308071651340.12315-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2003, Alan Cox wrote:
> > In an ideal world, I would like Linux to load the
> > microcode *before* the kernel boots, which begs the
> > question of "How?". Can you suggest anything, please?
> 
> The kernel can't load the microcode until it has booted, it can
> load it very early after that from initrd.

Well, it could even do it a little bit earlier, i.e. if we allowed linking
microcode data into the kernel image (as some scsi firmware data is, etc
and as __initdata so it's thrown away later) then it could update it very
very early, i.e. even before mounting the root filesystem. All it needs is
the ability to do IPIs and get the data from somewhere.

I could implement this, but if you tell me that this is not allowed
because of the GPL issues (microcode data chunks are copyrighted by Intel)
then obviously I won't waste time writing the code to do this.

Alternatively, yes, he can do it from within initrd. Hope that is early 
enough for him.

Kind regards
Tigran

