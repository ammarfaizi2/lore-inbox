Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTIIU5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTIIU5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:57:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:43196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264372AbTIIU5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:57:50 -0400
Date: Tue, 9 Sep 2003 14:04:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Power: call save_state on PCI devices along with suspend
In-Reply-To: <1063132902.1356.17.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309091354471.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Don't we want that ? It will help if any driver currently relies on
> the save_state callback to be called...

Bah, this patch slipped my mind. How many drivers actually use 
->save_state()? From a quick look, it looks like: 

1. drivers/ide/pci/sc1200.c
2. drivers/net/irda/vlsi_ir.c
3. drivers/scsi/nsp32.c
4. drivers/serial/8250_pci.c

Of those, only (1) actually does anything interesting. (2) and (3) only 
print a message, and (4) appears to be trivial to fold into ->suspend(). 

What do you think about just fixing those up? 



	Pat

