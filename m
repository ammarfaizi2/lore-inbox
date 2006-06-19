Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWFSUwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWFSUwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFSUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:52:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932305AbWFSUwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:52:08 -0400
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
In-Reply-To: <4496FEC2.8050903@rtr.ca>
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
	 <20060619184706.GH3479@flint.arm.linux.org.uk>  <4496FEC2.8050903@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 22:06:52 +0100
Message-Id: <1150751212.2871.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 15:45 -0400, ysgrifennodd Mark Lord:
> If the drivers are written "correctly", they shouldn't grab the IRQ
> until someone actually opens the device.  Which means they should be
> able the share the IRQ, so long as both devices are not in use (open)
> at the same time.

This is not the case for ISA bus. Most ISA hardware is physically unable
to share and the drivers for such hardware intentionally grab the IRQ at
load time to avoid it being mis-reused.

Alan

