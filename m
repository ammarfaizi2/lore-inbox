Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWGKOEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWGKOEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWGKOEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:04:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750800AbWGKOEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:04:10 -0400
Date: Tue, 11 Jul 2006 10:02:57 -0400
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-ID: <20060711140257.GA6820@devserv.devel.redhat.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060711125258.GN13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711125258.GN13938@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:52:58PM +0200, Adrian Bunk wrote:
>   CC      drivers/ide/pci/jmicron.o
> drivers/ide/pci/jmicron.c: In function ???ata66_jmicron???:
> drivers/ide/pci/jmicron.c:99: warning: control reaches end of non-void function

If your gcc does this please file a gcc bug report

> At least from gcc's perspective, this warning is correct, and it should 
> therefore be fixed.

No. port_type is an enum. Each enum value in question is present in the 
switch (and gcc knows this), each has a return. Your compiler is buggy.
