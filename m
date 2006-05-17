Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEQXsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEQXsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEQXsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:48:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21198 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750740AbWEQXsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:48:37 -0400
Message-ID: <446BB64E.1060509@garzik.org>
Date: Wed, 17 May 2006 19:48:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Avuton Olrich <avuton@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com> <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com> <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com> <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org> <87ves44qrs.fsf@duaron.myhome.or.jp> <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In particular, I have this pretty strong memory that we tried to do 
> something like this a long time ago, and it caused problems at least 
> with the legacy ISA/ATA interrupts (irq 14/15).
> 
> On the other hand, my memory is pretty damn bad at times, and besides, I 
> hope that that "hardcoded" case just above it is the one that takes care 
> of the old ATA interrupts. This is one of those times when the only 
> guaranteed right thing to do would be to be bug-for-bug compatible with 
> whatever crud MS-Win does..

Many BIOS ACPI tables from years ago simply _assumed_ that you have 
hardcoded irq 14/15, even...  Their irq descriptors for 14/15 would be 
absent or completely non-functional.

Or maybe its the $pirq table I'm recalling.  One of the two, anyway.

	Jeff



