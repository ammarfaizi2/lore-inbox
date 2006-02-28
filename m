Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWB1N2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWB1N2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 08:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWB1N2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 08:28:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61071 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750752AbWB1N2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 08:28:15 -0500
Subject: Re: libata PATA patch for 2.6.16-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mathieu Chouquet-Stringer <ml2news@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <m33bi3of5m.fsf@defiant.localdomain>
References: <1141054370.3089.0.camel@localhost.localdomain>
	 <m3k6bgk7oi.fsf@localhost.localdomain>
	 <1141085952.3089.23.camel@localhost.localdomain>
	 <m33bi3of5m.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Feb 2006 13:32:37 +0000
Message-Id: <1141133557.3089.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-28 at 13:12 +0100, Krzysztof Halasa wrote:
> "rmmod pata_via" and then "modprobe pata_via" is still there:
> 
> ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xE000 irq 14
> Unable to handle kernel NULL pointer dereference at virtual address 00000000


This appears to be a bug in the libata core code. I can duplicate it
with a NULL driver that simply fakes no devices attached. It definitely
needs looking at but I don't think its PATA caused at this moment. Of
course I may yet be wrong 8)

Alan

