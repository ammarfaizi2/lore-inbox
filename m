Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTEPDxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 23:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTEPDxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 23:53:42 -0400
Received: from mail.donpac.ru ([217.107.128.190]:2752 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264352AbTEPDxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 23:53:41 -0400
Date: Fri, 16 May 2003 08:06:30 +0400
To: Jes Sorensen <jes@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla1280 mem-mapped I/O fix
Message-ID: <20030516040630.GA20160@pazke>
Mail-Followup-To: Jes Sorensen <jes@wildopensource.com>,
	linux-kernel@vger.kernel.org
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com> <1052561708.1367.0.camel@laptop.fenrus.com> <m3addoqkaa.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3addoqkaa.fsf@trained-monkey.org>
X-Uname: Linux 2.5.68 i686 unknown
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -38.8 (--------------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GWUK-0002pU-4Y*1168TltBmyY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 135, 05 15, 2003 at 11:52:45AM -0400, Jes Sorensen wrote:
> >>>>> "Arjan" == Arjan van de Ven <arjanv@redhat.com> writes:
> 
> >> @@ -2634,7 +2634,7 @@ /* * Get memory mapped I/O address.  */ -
> >> pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase); +
> >> pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
> >> mmapbase &= PCI_BASE_ADDRESS_MEM_MASK;
> >> 
> >> 
> Arjan> shouldn't this be pci_resource_start() ?
> 
> Yep,
> 
> The existing code is a nightmare, I am working on cleaning this up so
> we can get rid of all the I/O ports crap.

Do you want to convert this driver to use memmaped io only ?

That's bad news for me and visws subarch.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net
