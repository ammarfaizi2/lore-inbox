Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWBRHuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWBRHuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 02:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWBRHuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 02:50:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750975AbWBRHuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 02:50:06 -0500
Date: Fri, 17 Feb 2006 23:48:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brian Hall <brihall@pcisys.net>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060217234841.5f2030ec.akpm@osdl.org>
In-Reply-To: <20060218003622.30a2b501.brihall@pcisys.net>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Hall <brihall@pcisys.net> wrote:
>
> Using sk98lin this "almost" worked- brought the line up, got a
>  gigabit connection light on my switch, but trying to assign an IP to
>  the interface results in a kernel panic. Not good...

As Randy says, sky2 looks like your best bet.

>  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
>  reason it fails to access the card, maybe because I have an ULi chipset?
> 
>  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config space

Looks like something died way down in the PCI bus config space read/write
operations.  I don't know what would cause that.  You could perhaps play
with `pci=conf1', `pci=conf2', etc as per
Documentation/kernel-parameters.txt.

