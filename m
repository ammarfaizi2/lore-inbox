Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUHLJTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUHLJTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHLJT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:19:29 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:18703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbUHLJTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:19:08 -0400
Date: Thu, 12 Aug 2004 10:19:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 8 of 21
Message-ID: <20040812101904.F5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408112330.i7BNUK54163392@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408112330.i7BNUK54163392@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:30:20PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:30:20PM -0500, Pat Gefre wrote:
> > 004-pci-bridge_drivers:
> >    You still have code dealing with all kinds of PCIIO_ and PCIBR_ flags
> >    that will never be set through the Linux interfaces.  Again see the DMA
> >    mapping code I sent you.
> > 
> 
> The PCIIO_ flags are designed for usage at the Device Driver layer, 
> while the PCIBR_ flags are designed to be the actual hardware bits that needed 
> setting.  However, with the latest code, we have deleted the PCIIO_ and 
> PCIBR_ flags that are not used.

There still are tons that are used in the code, but never logically set from
the exported interfaces.

