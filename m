Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbULGOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbULGOCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbULGOCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:02:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34252 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261776AbULGOCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:02:10 -0500
Subject: Re: aic7xxx driver large integer warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41B4971E.6060401@sombragris.com>
References: <41B3A683.8060008@sombragris.com>
	 <1102339898.13423.28.camel@localhost.localdomain>
	 <41B4971E.6060401@sombragris.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1102424299.17950.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Dec 2004 12:58:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-06 at 17:30, Miguel Angel Flores wrote:
> Sure, but the 39 bit variable is only used when the type of dma_addr_t 
> is u64. I think that is more clean to put this assignement inside the if 
> block, like the rest of the CONFIG_HIGHMEM64G code. Anyway the 
> (dma_addr_t) cast can be added too.
> 
> ¿how you would solve this?

I'd just add the cast. The compiler will truncate it to FFFFFFFF if
appropriate.


