Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUK3Tmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUK3Tmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUK3Tma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:42:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10654 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262293AbUK3TmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:42:06 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <22DA85F23E4@vcnet.vc.cvut.cz>
References: <22DA85F23E4@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101839900.25628.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:38:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 18:29, Petr Vandrovec wrote:
> If this is going to stay, I have one possible user.  VMware's vmmon needs
> to allocate two pages from memory below 4GB so it can use these pages
> for code and page table root while switching from long mode to legacy

That would also be a proprietary hook wouldn't it 8)

So far I can find none although I can find users for a 512Mb or 1Gb DMA
region. Several sound cards would benefit from this as would b44 and to
a small extent aacraid but no users who benefit for 32bit DMA. In the
video space it's even stranger because DRI doesn't need it, fbcon
doesn't need it and even beyond the supported open source hardware
PCI-Express is the non-AGPGART user and that is 64bit. Even for the
users I can find it seems a risky path because of the past problems
trying to get zone balancing working.

Or do we have someone whose driver is not only proprietary but has crap
hardware ?

Alan

