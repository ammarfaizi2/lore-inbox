Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUEPSCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUEPSCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264716AbUEPSCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:02:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:5794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264702AbUEPSCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:02:20 -0400
Date: Sun, 16 May 2004 11:02:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
In-Reply-To: <40A7AA0B.5000200@pacbell.net>
Message-ID: <Pine.LNX.4.58.0405161101160.25502@ppc970.osdl.org>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de>
 <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <40A7AA0B.5000200@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, David Brownell wrote:
> 
> Speaking of which, please consider merging this.  It
> missed Greg's push on Friday, but it's needed to build
> OHCI and EHCI with CONFIG_USB_DEBUG when !CONFIG_PM.

I really have #ifdef's inside code. Even when it is in header files.

So I'd much rather just have two different functions, one in the CONFIG_PM 
section, and one in the !CONFIG_PM one. That's how we already do 
everything else in that header file (and how we handle PCI etc).

		Linus
