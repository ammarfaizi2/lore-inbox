Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUHaMqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUHaMqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHaMqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:46:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268197AbUHaMmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:42:17 -0400
Date: Tue, 31 Aug 2004 07:53:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>,
       greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] - drivers/pci/pci.c NULL pointer fix.
Message-ID: <20040831105339.GD3774@logos.cnet>
References: <20040830124733.7d44dbe1.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830124733.7d44dbe1.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, 

Thanks.

On Mon, Aug 30, 2004 at 12:47:33PM -0300, Luiz Fernando N. Capitulino wrote:
>  Marcelo,
> 
>  This is another bug fix: the function pci/pci.c::pci_add_new_bus() does not
> check the return of pci_alloc_bus(). If this function returns NULL, `child'
> can be utilised.
> 
>  In the patch bellow I added the check, if the call that pci_scan_bridge()
> is doing to pci_alloc_bus() return NULL, pci_scan_bridge() returns `max'
> (Greg accepted this fix for 2.6, a while ago).
> 
> (against 2.4.28-pre2)
> 
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>
