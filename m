Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbRF1NdO>; Thu, 28 Jun 2001 09:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbRF1NdF>; Thu, 28 Jun 2001 09:33:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265732AbRF1Nc4>; Thu, 28 Jun 2001 09:32:56 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: dhowells@redhat.com (David Howells)
Date: Thu, 28 Jun 2001 14:32:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, dwmw2@redhat.com, arjanv@redhat.com,
        alan@redhat.com
In-Reply-To: <30906.993734004@warthog.cambridge.redhat.com> from "David Howells" at Jun 28, 2001 02:13:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FbuU-0006wH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Also on an i386, the actual I/O instruction itself is going to take a
>    comparatively long time anyway, given the speed differential between CPU
>    and external buses.

PCI memory (and sometimes I/O) writes are posted, Since x86 memory writes are
also parallelisable instructions and since the CPU merely has to retire the
writes in order your stall basically doesnt exist.

High end devices tend to have you writing them to them and they DMA into your
RAM so its a concern

