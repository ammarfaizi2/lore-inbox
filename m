Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTIPNYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTIPNYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:24:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43684 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261242AbTIPNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:24:10 -0400
Subject: Re: Linux 2.4.22-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Steffl <steffl@bigfoot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F664FED.4040609@bigfoot.com>
References: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
	 <3F664FED.4040609@bigfoot.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063718562.10037.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 14:22:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 00:49, Erik Steffl wrote:
>    does this apply to SATA disks?

The only SATA devices we support in the core IDE layer are capable of
doing LBA48 DMA anyway. 

>    what's the status of support for 137GB+ SATA disks? it required 
> libata5 patches from Jeff Garzik before (as of 2.4.21-ac4). I see some

libata is really seperate and for the newer controllers. Its more aimed
at the latest and upcoming hardware which replaces the SATA controller
as we know it today (PATA controller hacked up a bit) with stuff that
looks more like a SCSI controller, with multiple commands, on board
brains etc. Things like the Promise 2037x are the beginnings of this.

