Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSLPA7L>; Sun, 15 Dec 2002 19:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSLPA7K>; Sun, 15 Dec 2002 19:59:10 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:32140 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S264945AbSLPA7J>;
	Sun, 15 Dec 2002 19:59:09 -0500
Date: Sun, 15 Dec 2002 19:07:04 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 (minor) Alpha probs in 2.5.51
Message-Id: <20021215190704.307022c3.arashi@arashi.yi.org>
In-Reply-To: <20021216003327.GC709@gallifrey>
References: <20021216003327.GC709@gallifrey>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002 00:33:27 +0000
"Dr. David Alan Gilbert" <gilbertd@treblig.org> wrote:

> (This is with rth's exception patch to fix the mount problem).
> 
> 1) If compiled for the LX164 platform it is missing a number of symbols
> at link time (fine if built generic):
> 
> arch/alpha/kernel/built-in.o(.data+0x3030): undefined reference to
> `cia_bwx_inb'
> arch/alpha/kernel/built-in.o(.data+0x3038): undefined reference to
> `cia_bwx_inw'
> .
> .
> .
> (and a handful more)

I had this exact same problem the other day, and this is fixed in -bk now.
Remove the #include <asm/io.h> in include/asm/pci.h.

Matt
