Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUAATe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUAATe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:34:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:2183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264540AbUAATez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:34:55 -0500
Date: Thu, 1 Jan 2004 11:34:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Juergen Hasch <lkml@elbonia.de>
cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 compile error
In-Reply-To: <200401011026.00520.lkml@elbonia.de>
Message-ID: <Pine.LNX.4.58.0401011133050.2065@home.osdl.org>
References: <200401010109.12005.harisri@bigpond.com> <200401011026.00520.lkml@elbonia.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jan 2004, Juergen Hasch wrote:
> 
> Linus introduced this function a few weeks ago. I used the patch below to move 
> the function from kernel/irq.c to pci/irq.c, but he will probably fix it
> himself soon.

I'd much rather have x86-64 have their own version. I would prefer to keep
the irq knowledge in the irq layer. Eventually that irq layer will get
unified, but for now I do _not_ want some random PCI file to know about
irq handler internal data structures.

		Linus
