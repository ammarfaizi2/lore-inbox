Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTD3NJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTD3NJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:09:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262167AbTD3NJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:09:54 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304301325.h3UDPtla000141@81-2-122-30.bradfords.org.uk>
Subject: Re: Bootable CD idea
To: tigran@veritas.com (Tigran Aivazian)
Date: Wed, 30 Apr 2003 14:25:55 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0304301446450.2375-100000@einstein31.homenet> from "Tigran Aivazian" at Apr 30, 2003 02:47:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1] I originally thought that the 2.4 kernel's in-built floppy
> > bootloader used BIOS calls to access the disk, and that a 2.4 kernel
> > image as the El-Torito boot image would work, as the kernel would be
> > accessing the emulated disk, but it didn't seem to when I tried it
> > just now - it failed with an error saying something along the lines of
> > it had run out of data to decompress.
> 
> when you did "make bzImage", are you sure you didn't get the message about 
> the kernel being too big for floppy booting?

No, I've just checked - the same kernel image boots fine from a real floppy.

The CD image just gives:

Loading ...........................
Uncompressing Linux ...

Ran out of input data

--- System halted

Looking at bootsect.S, I am suprised it doesn't work, as it's done via
Int 0x13, so I can't see why it doesn't see the BIOS-emulated floppy
correctly.

John.
