Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313448AbSDGTlu>; Sun, 7 Apr 2002 15:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313450AbSDGTlt>; Sun, 7 Apr 2002 15:41:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313448AbSDGTls>; Sun, 7 Apr 2002 15:41:48 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: movement@marcelothewonderpenguin.com (John Levon)
Date: Sun, 7 Apr 2002 20:58:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407193245.GA21570@compsoc.man.ac.uk> from "John Levon" at Apr 07, 2002 08:32:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIoN-0006b3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system call tracking is only used to associate a particular EIP with
> a particular offset in some binary image. There's no other efficient
> method to capture the mmap() calls for these images, for everything
> running. ptrace() is only really useful for a small number of processes,
> and is slow. Offline post-analysis isn't possible. There is no
> API for getting access to this information.

Ok, so you have a real reason for dealing with it

> Removing sys_call_table from exports won't have any positive effect.
> Using it has always been "well, you're on your own" - if there is a
> really good reason it needs to be changed, fine; but just changing it
> because it's not supposed to be used isn't a good enough reason when
> there is actually a couple of niche cases where it's the only option.

Lets see if we can sort out AFS and the like then come back to that one. I
think you may have a valid point. If 2.5 has EXPORT_SYMBOL_INTERNAL it 
gets a lot easier.
