Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264092AbRGCLyG>; Tue, 3 Jul 2001 07:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264103AbRGCLx4>; Tue, 3 Jul 2001 07:53:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264092AbRGCLxk>; Tue, 3 Jul 2001 07:53:40 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: dhowells@redhat.com (David Howells)
Date: Tue, 3 Jul 2001 12:53:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dhowells@redhat.com (David Howells),
        jes@sunsite.dk (Jes Sorensen), dwmw2@redhat.com,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3911.994146916@warthog.cambridge.redhat.com> from "David Howells" at Jul 03, 2001 08:55:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HOjy-0007aR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, one board I've got doesn't allow you to do a straight
> memory-mapped I/O access to your PCI device directly, but have to reposition a
> window in the CPU's memory space over part of the PCI memory space first, and
> then hold a spinlock whilst you do it.

What does this prove. PA-RISC has this problem in reverse for I/O cycle access
to PCI slots on hppa1.1 at least. Cookies work _fine_

And by the time you are taking a spinlock who cares about the add, you can do
that while the bus transactions for the atomic op are completing

On the other hand each call, each push of resource * pointers costs real clocks
on x86

