Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbUK3To7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbUK3To7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbUK3Tm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:42:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11166 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262289AbUK3TmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:42:13 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130183151.GA26967@infradead.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101837994.2640.67.camel@laptop.fenrus.org>
	 <20041130183151.GA26967@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101839913.25609.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:38:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 18:31, Christoph Hellwig wrote:
> The purpose is probably to work around 32bit DMA limited devices on the broken
> iAMD64 systems.
> 
> But I think it's a bad idea, x86_64 doesn't use CONFIG_HIGHMEM at all currenly,
> and it could easily use it for that purpose like in the patch in older RH
> kernels for ia64.

We had very bad experiences with zone balancing that configuration and
I'm concerned we'd see the same again with such a zone on systems.
Particulary since nothing I can find needs such a zone but can use
swiommu and the I/O MMU on some AMD boxes.


