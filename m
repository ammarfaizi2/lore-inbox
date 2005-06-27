Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVF0Vsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVF0Vsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0Vo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:44:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261875AbVF0VnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:43:17 -0400
Date: Mon, 27 Jun 2005 22:43:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@americas.sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, sskowron@et.put.poznan.pl
Subject: Re: [PATCH 2.6] Altix - add ioc3 serial driver support
Message-ID: <20050627214307.GA28382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@americas.sgi.com>, Pat Gefre <pfg@sgi.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	sskowron@et.put.poznan.pl
References: <20050626184557.GA21428@infradead.org> <Pine.SGI.3.96.1050627161134.39433C-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1050627161134.39433C-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 04:25:48PM -0500, Pat Gefre wrote:
> Something I didn't make clear - the driver that I am adding is a pci
> card based on the IOC3 serial part - it is a single function card - 2
> serial ports. This is supported on Altix.
> 
> The driver that is in drivers/net is to support a (full) IOC3 card -
> ethernet and serial ports. This is not supported on Altix. Only the
> newer IOC4 is supported (it also has serial ports among other things).
> 
> They are two different pieces of hardware.

Actually both of them use the same chip and same pci id (hint: you could
have used the proper PCI ID definition from pci_ids.h instead of adding
your own which is discouraged :)), so it's not as easy.

Stanislaw Skowronek has been done a lot of work on supporting the IOC3
fully, maybe you could get into contact with him?  I'm pretty sure
everyone in mips land is appreciating your fully featured serial
driver, let's just make sure it fits into the general framework.
