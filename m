Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTD2OKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 10:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbTD2OKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 10:10:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13715
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262019AbTD2OKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 10:10:01 -0400
Subject: Re: Stack Trace dump in do_IRQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chandrasekhar.nagaraj@patni.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
References: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051622613.18198.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 14:23:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-29 at 13:34, Chandrasekhar wrote:
> On going through the do_IRQ code in arch/i386/kernel/irq.c we found that is
> is used for debugging check for stack overflow i.e if the stack size is less
> than 2KB free.
> There is no similar debugging check in other kernels like 2.4.7-10,2.4.18-3
> and 2.4.18-14.
> What is the significance of this debugging information and why other kernels
> dont have the same check? Also, if the stack overflow can cause future
> problems, then
> how can we increase the stack size? Thanks in advance for any information on
> this.

You can't. A driver has to work with a very small stack size.

