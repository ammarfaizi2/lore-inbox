Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbUK3Slu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUK3Slu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUK3Sdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:33:43 -0500
Received: from [213.146.154.40] ([213.146.154.40]:17888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262250AbUK3Sbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:31:53 -0500
Date: Tue, 30 Nov 2004 18:31:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041130183151.GA26967@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041130095045.090de5ea.akpm@osdl.org> <1101837994.2640.67.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101837994.2640.67.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 07:06:34PM +0100, Arjan van de Ven wrote:
> On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> > 
> > - Various fixes and cleanups
> > 
> > - A decent-sized x86_64 update.
> > 
> > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
> >   reclaim, but shouldn't.
> 
> 
> what is the purpose of such a zone ??

The purpose is probably to work around 32bit DMA limited devices on the broken
iAMD64 systems.

But I think it's a bad idea, x86_64 doesn't use CONFIG_HIGHMEM at all currenly,
and it could easily use it for that purpose like in the patch in older RH
kernels for ia64.
