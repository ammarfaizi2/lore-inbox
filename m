Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVIOQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVIOQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVIOQe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:34:57 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:61578 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030523AbVIOQe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:34:56 -0400
Date: Thu, 15 Sep 2005 10:34:55 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: viro@ZenIV.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] killing linux/irq.h
Message-ID: <20050915163455.GD16698@parisc-linux.org>
References: <20050909184254.GT9623@ZenIV.linux.org.uk> <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 09:50:38AM +0200, Geert Uytterhoeven wrote:
> On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> > 	We get regular portability bugs when somebody decides to include
> > linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
> > wrong thing to do and, in fact, causes immediate breakage on e.g. arm.
> 
> Wouldn't it be more logical to make linux/irq.h the preferred include?
> Usually the linux/* versions are preferred over the asm/* versions.

There's almost no reason to want <*/irq.h> in the first place.  Almost
all drivers really want <linux/interrupt.h>
