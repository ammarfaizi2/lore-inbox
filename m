Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267541AbUHJQmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267541AbUHJQmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUHJQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:41:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:49346 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267541AbUHJQJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:09:43 -0400
Date: Tue, 10 Aug 2004 09:07:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, sziwan@hell.org.pl
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
Message-Id: <20040810090743.3fa75a74.akpm@osdl.org>
In-Reply-To: <4118A500.1080306@free.fr>
References: <41189098.4000400@free.fr>
	<4118A500.1080306@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> Eric Valette wrote:
>  > I tried 2.6.8-rc4-mm1 on my ASUS L3800C laptop (radeon 7500), defined 
>  > CONFIG_FB_MODE_HELPERS and I have got a hard freeze when starting X and 
>  > framebuffer console with a lot of yellow dot on the bottom screen. 
>  > Suddently I hear the fan meaning the machine is dead
> 
>  OK I've reverted the most suspect change 
>  (remove-unconditional-pci-acpi-irq-routing.patch) and it did not fix the 
>  problem. As Karol Kozimor suspected ACPI, I then tried with acpi=off and 
>  then it boot but I will burn my CPU as fans are ACPI controlled...

Are you sure that the problem is due to ACPI?  I'd have been suspecting the
video mode database rewrite (video-mode-handling-*.patch).
