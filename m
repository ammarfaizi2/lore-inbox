Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUAGO06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUAGO05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:26:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59653 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266126AbUAGO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:26:55 -0500
Date: Wed, 7 Jan 2004 14:26:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
Message-ID: <20040107142652.A29251@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040106010924.GA21747@sgi.com> <20040106102538.A14492@infradead.org> <yq04qv8ypkp.fsf@wildopensource.com> <20040107112648.A27801@infradead.org> <yq0znczyhux.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq0znczyhux.fsf@wildopensource.com>; from jes@wildopensource.com on Wed, Jan 07, 2004 at 09:05:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 09:05:10AM -0500, Jes Sorensen wrote:
> Christoph> That's stupid.  You should just not be allowed to compile
> Christoph> the driver if it can work anywork.
> 
> I don't know if it's actually possible to use the card in a non-SN2,
> not that I think anyone would want to. But if you prefer, just make
> the equivalent change to the Kconfig file and remove the weak
> reference.

It might be possible to use an IOC4 card in other hardware, but not
with this driver, as it relies on Xbridge/PIC to do byteswapping for
it - a functionality common PCI bridges don't provide and that Linux
doesn't have a generic API for.

