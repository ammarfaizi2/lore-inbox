Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVBSOI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVBSOI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 09:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVBSOI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 09:08:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:55704 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261717AbVBSOHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 09:07:36 -0500
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Gortmaker <penguin@muskoka.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4216CCAC.1050807@pobox.com>
References: <41DED9FA.7080106@pobox.com>  <41DF9AC1.2010609@muskoka.com>
	 <1105197689.10505.22.camel@localhost.localdomain>
	 <41E1EB68.5000709@muskoka.com>
	 <1105381093.12028.81.camel@localhost.localdomain>
	 <4216CCAC.1050807@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108821972.15518.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Feb 2005 14:06:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-02-19 at 05:20, Jeff Garzik wrote:
> > It means that padto has improved a lot (or the underlying allocators).
> > It also still means the patch makes the code slower and introduces
> > changes that have no benefit into the kernel, so while its good to see
> > its not relevant its still a pointless change.
> 
> So the verdict is to revert?

Not sure. The old code is known to work and a fraction faster, the new
code makes the driver use the same logic as the others. Having seen the
numbers from Paul I personally don't care either way.

