Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbULFOfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbULFOfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbULFOfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:35:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:52682 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261530AbULFOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:35:13 -0500
Subject: Re: aic7xxx driver large integer warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41B3A683.8060008@sombragris.com>
References: <41B3A683.8060008@sombragris.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102339898.13423.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 13:31:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-06 at 00:23, Miguel Angel Flores wrote:
> drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:229: warning: large integer 
> implicitly truncated to unsigned type
> ---

Add (dma_addr_t) casts and it will go away. The compiler just wants to
know you mean it.


