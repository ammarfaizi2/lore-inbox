Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268542AbUHLM7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268542AbUHLM7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268549AbUHLM7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:59:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62164 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268542AbUHLM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:59:03 -0400
Subject: Re: x86 - Realmode BIOS and Code calling module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakub Vana <gugux@centrum.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
References: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092311802.21978.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 12:56:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 10:36, Jakub Vana wrote:
> Hello,
> 
> I have written Linux Kernel module that allows you to call BIOS
> interupts, Far services or your own code. 

Why is this better than LRMI in user mode. To do BIOS calls safely
you need to be very careful about things like PCI locking, I/O 
emulation and the ROM scribbling in strange places. LRMI can handle this
in user space as does x86emu in Xorg.

All you should thus need is an ioctl in vesafb to tell it you've 
changed the display properties and here is the new layout to use.

