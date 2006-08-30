Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWH3TiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWH3TiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWH3TiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:38:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:954 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751375AbWH3TiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:38:19 -0400
Date: Wed, 30 Aug 2006 14:38:17 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mem driver: fix conditional on isa i/o support
Message-ID: <20060830193817.GB8704@austin.ibm.com>
References: <44F4F1B9.9060605@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F4F1B9.9060605@am.sony.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 07:02:33PM -0700, Geoff Levand wrote:
> This change corrects the logic on the preprocessor conditionals
> that include support for ISA port i/o (/dev/ioports) into
> the mem character driver.
> 
> This fixes the following error when building for powerpc
> platforms with CONFIG_PCI=n.
> 
>   drivers/built-in.o: undefined reference to `pci_io_base'
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Discussd very breifly on ppc64 mailing list, seems to be 
the right thing to do.

Acked-by: Linas Vepstas <lins@austin.ibm.com>


--linas
