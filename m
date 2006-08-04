Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWHDJFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWHDJFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWHDJFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:05:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161113AbWHDJFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:05:34 -0400
Date: Fri, 4 Aug 2006 02:04:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, rdunlap@xenotime.net, davej@redhat.com,
       chuckw@quantumlinux.com, reviews@ml.cw.f00f.org,
       alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org, jes@sgi.com
Subject: Re: [patch 12/23] invalidate_bdev() speedup
Message-Id: <20060804020422.09b32164.akpm@osdl.org>
In-Reply-To: <20060804085012.GA20026@infradead.org>
References: <20060804053258.391158155@quad.kroah.org>
	<20060804053942.GM769@kroah.com>
	<20060804085012.GA20026@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 09:50:13 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Aug 03, 2006 at 10:39:42PM -0700, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> This is a feature.  Definitly not -stable material.

Apparently that regular IPI storm is causing the SGI machines some
significant problems.  I assume it's the interrupt latency problem again.
Jes would know.

It's not the biggest problem we've ever had, but if this patch is wrong,
the pagecache/buffer_head layer is utterly busted.  And it isn't.

