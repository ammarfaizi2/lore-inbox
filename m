Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLWQzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLWQzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:55:16 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:49168 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261950AbTLWQzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:55:11 -0500
Date: Tue, 23 Dec 2003 16:55:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Colin Ngam <cngam@sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031223165506.A8624@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Ngam <cngam@sgi.com>, Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FE85533.E026DE86@sgi.com>; from cngam@sgi.com on Tue, Dec 23, 2003 at 08:46:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 08:46:11AM -0600, Colin Ngam wrote:
> You are ofcourse talking about linux/drivers/.. right?

My plans are to move the code to drivers/xtalk/ once it's finished, es.

> IP27 is not a supported architecture under linux/arch/ia64/sn/io/..
> The IP27 MIPS processor/io hardware(bridge/Xbridge)/BIOS for IP27 are very much
> different than our SN2 product, supported within the linux/arch/ia64 tree -
> ia64 processors, IO Chipsets(PIC, TIO(CP,CA)), and System BIOS.
> 
> Is that not supported under the linux/arch/mips tree?

It's currently supported, but I'm aiming for common code for the common
parts (pcibr drivers,  xbow driver, hub/shub driver, xtalk discovery,
some prom interface code).  I've already sent you my merged dma mapping
code and I have similar code for hub and bridge/xbridge/pic/tiocp level
pio mapping and xtalk discovery.

There's of course code that will stay in the per-arch directories like
the lowlevel interrupt code, etc..  Now this isn't something that happens
from one day to another, but not not putting stones in the way of each
other would help greatly..

