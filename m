Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVF1Mcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVF1Mcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVF1Mcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:32:48 -0400
Received: from [85.8.12.41] ([85.8.12.41]:13241 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261448AbVF1Mcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:32:45 -0400
Message-ID: <42C1434F.2010003@drzeus.cx>
Date: Tue, 28 Jun 2005 14:32:15 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, kjhall@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42C0EE1A.9050809@drzeus.cx>
In-Reply-To: <42C0EE1A.9050809@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Hmm... it seems that TPM has something to do with the bug. Not sure why
> though, can't see anything TPM related in dmesg. If I disable the TPM
> parts in kconfig then the network works just fine.
> 
> I'm going to do a test of 2.6.12-rc1 through rc6 today to see where the
> problem appears.
> 

Confirmed this behaviour. The problem appears in rc1 (where the TPM is
added). Unloading the module doesn't help, once it has been present the
system needs a reboot for the network card to function properly.

I don't really see how the TPM can screw things up for the network card
but I'm guessing it breaks something in the chipset (the TPM module gets
loaded for the LPC bridge).

(added TPM maintainer and list as cc)

Rgds
Pierre
