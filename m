Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVI3Rvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVI3Rvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVI3Rvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:51:36 -0400
Received: from [81.2.110.250] ([81.2.110.250]:50904 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932549AbVI3Rvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:51:36 -0400
Subject: Re: Opterons and setting the pci bus master bit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <433D71A0.1040104@compro.net>
References: <433D71A0.1040104@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Sep 2005 19:19:02 +0100
Message-Id: <1128104342.17099.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-30 at 13:10 -0400, Mark Hounschell wrote:
> everything is fine. When we connect the same chassis to an Intel P4 box 
> everything is fine. It looks like it is the kernel that sets this bit 
> because we have never set it in any of our drivers, yet on the intel 
> boxes it gets set. Why would this bit not be set when the chassis is 
> connected to an Opteron. We are running 32-bit mode BTW. I am using a 
> 2.6.11.9 kernel. Is this a motherboard problem or could this be a kernel 
> problem?

If your device needs to bus master you need to call
pci_set_master(pci_dev). The bus mastering setup prior to that really
depends on the BIOS and phase of the moon.

See Documentation/pci.txt

Alan

