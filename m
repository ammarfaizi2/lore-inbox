Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUDGOdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbUDGOdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:33:50 -0400
Received: from ozlabs.org ([203.10.76.45]:35543 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263671AbUDGOdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:33:49 -0400
Date: Thu, 8 Apr 2004 00:30:08 +1000
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: create dma_mapping_error
Message-ID: <20040407143008.GP26474@krispykreme>
References: <1080923616.1829.73.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080923616.1829.73.camel@mulgrave>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What exactly are you guys doing?
> 
> The API Anton introduced:  dma_mapping_error() takes only a virtual
> address as the argument (no struct device or anyting), so the additional
> API's pci_dma_mapping_error() and vio_dma_mapping_error have absolutely
> no choice but to do the same thing as dma_mapping_error() (because the
> error return cannot be bus or device specific).

Umm yeah, we should probably just use dma_mapping_error. I want to see
vio_* disappear anyway.

Anton
