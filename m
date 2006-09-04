Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWIDKyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWIDKyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWIDKyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:54:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14806 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750747AbWIDKym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:54:42 -0400
Subject: Re: 2.6.18-rc5 + pata-drivers on MSI K9N Ultra report, AMD64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <m3lkp1anwf.fsf@defiant.localdomain>
References: <m3psee58lg.fsf@defiant.localdomain>
	 <1157234944.6271.400.camel@localhost.localdomain>
	 <m3lkp1anwf.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 12:16:35 +0100
Message-Id: <1157368595.30801.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-03 am 00:45 +0200, ysgrifennodd Krzysztof Halasa:
> Hmmm... is it that 0x62, isn't it?
> 
>         static struct pci_bits amd_enable_bits[] = {
>                 { 0x40, 1, 0x02, 0x02 },
>                 { 0x40, 1, 0x01, 0x01 }
>         };

The Nvidia ones have the register base at 0x50. Looking at the code I
think its just a case of adding an 0x50 based enable_bits test to
nv_pre_reset, and I'll fold that in now.




-- 
VGER BF report: U 0.474419
