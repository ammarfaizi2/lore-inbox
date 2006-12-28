Return-Path: <linux-kernel-owner+w=401wt.eu-S933025AbWL1ShX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025AbWL1ShX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWL1ShX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:37:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56993 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933025AbWL1ShW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:37:22 -0500
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@kvack.org>
In-Reply-To: <45940E3F.1050506@shaw.ca>
References: <fa.Nb4Y/frBNPmoag6ZL4pL3qEyDOs@ifi.uio.no>
	 <fa.XVmR+7tQ0v2oWVb7eyfQ8pGFhp8@ifi.uio.no>  <45940E3F.1050506@shaw.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 19:37:20 +0100
Message-Id: <1167331040.3281.4363.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 12:34 -0600, Robert Hancock wrote:

Hi,

> > since one gets random corruption if a user gets this wrong, at least
> > make things like floppy and all CONFIG_ISA stuff conflict with this
> > option.... without that your patch feels like a walking time bomb...
> > (and please include all PCI drivers that only can do 24 bit or 28bit
> > or .. non-32bit dma as well)
> 
> That sounds like a bug if this can happen. Drivers should be failing to 
> initialize if they can't set the proper DMA mask, and the DMA API calls 
> should be failing if the requested DMA mask can't be provided.

...but Marcelo's patch doesn't implement anything of that kind....
In addition, many ISA bus drivers do not use the DMA API *at all*
currently. If you want to fix them all up, great! But somehow I doubt
those will get fixed in the next decade.. they've been like this for at
least half a decade or longer :-)

Greetings,
   Arjan van de Ven


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

