Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUAFKZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUAFKZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:25:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261825AbUAFKZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:25:39 -0500
Date: Tue, 6 Jan 2004 10:25:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
Message-ID: <20040106102538.A14492@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040106010924.GA21747@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040106010924.GA21747@sgi.com>; from jbarnes@sgi.com on Mon, Jan 05, 2004 at 05:09:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:09:24PM -0800, Jesse Barnes wrote:
> The 'depends' directive for SGI IOC4 support is too restrictive.  Just
> kill it altogether.

Umm, it won't work for anything but a kernel with SN2 support compile in
due to the bridge-level dma byteswapping it needs (through a week symbol,
that's why you don't see compile failures for other architectures, eek!).

So at least make it depend on CONFIG_IA64

