Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUH0Pif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUH0Pif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUH0Pie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:38:34 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60938 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266216AbUH0Pg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:36:56 -0400
Date: Fri, 27 Aug 2004 16:36:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827163654.A32236@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412F4EC9.7050003@sgi.com>; from pfg@sgi.com on Fri, Aug 27, 2004 at 10:10:01AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> io_init.c  iomv.c  Makefile  pci  pci_dma.c  pci_extension.c
> 
> arch/ia64/sn/ioif/pci:
> Makefile  pcibr_ate.c  pcibr_dma.c  pcibr_provider.c  pcibr_reg.c  xtalk_providers.c
> 

So why are pci_dma.c and pci_extensions.c not under pci?  You probably should
just kill that pci subdir, too when there's just two other files left.  Or
move those two to kernel/ and have a pci/ subdir which seems to fit other
ports quite well.  But I'd rather see the functional changes first and then
do renaming of unchanged files last anyway so you changed get actually
reviewable.  The current patchkit is not.


