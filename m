Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266005AbRF1QDt>; Thu, 28 Jun 2001 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRF1QDm>; Thu, 28 Jun 2001 12:03:42 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:47885 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266005AbRF1QDb>;
	Thu, 28 Jun 2001 12:03:31 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dhowells@redhat.com (David Howells),
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <E15FbuU-0006wH-00@the-village.bc.nu> <7040.993736538@redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 28 Jun 2001 18:02:35 +0200
In-Reply-To: David Woodhouse's message of "Thu, 28 Jun 2001 14:55:38 +0100"
Message-ID: <d3bsn8bnj8.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

David> Having per-resource I/O methods would help us to remove some of
David> the cruft which is accumulating in various non-x86 code. Note
David> that the below is the _core_ routines for _one_ board - I'm not
David> even including the extra indirection through the machine vector
David> here....

Have you considered the method used by the 8390 Ethernet driver?
For each device, add a pointer to the registers and a register shift.

I really don't like hacing virtual access functions that makes memory
mapped I/O look the same as I/O operations. For memory mapped I/O you
want to be able to smart optimizations to reduce the access on the PCI
bus (or similar).

Jes
