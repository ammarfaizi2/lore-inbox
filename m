Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423296AbWJSLSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423296AbWJSLSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423297AbWJSLSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:18:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62150 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423296AbWJSLSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:18:15 -0400
Subject: Re: Re[2]: pci_fixup_video change blows up on sparc64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: eiichiro.oiwa.nm@hitachi.com
Cc: David Miller <davem@davemloft.net>, alan@redhat.com,
       jesse.barnes@intel.com, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
References: <20061018.233102.74754142.davem@davemloft.net>
	 <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
	 <20061019.013732.30184567.davem@davemloft.net>
	 <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 12:20:34 +0100
Message-Id: <1161256834.17335.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 19:01 +0900, ysgrifennodd
eiichiro.oiwa.nm@hitachi.com:
> It's impossible that multiple VGA cards, which have not the expansion
> ROM, exist in a system regardless of multiple PCI domain system.

Strange. I've worked on several machines where it could.

The 0xC0000 is a physical address only as far as the bridge is concerned
(if the bridge even implements it - not all do). The PCI bus or busses
may not even be the root busses of the system. On such systems you can
happily have multiple PCI root bridges each in their own address space
and each with their own idea of where 0xC0000 maps if anywhere.


