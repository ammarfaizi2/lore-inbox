Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVHRKGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVHRKGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVHRKGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:06:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25318 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932166AbVHRKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:06:29 -0400
Date: Thu, 18 Aug 2005 11:06:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-ID: <20050818100628.GA5629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <20050818100151.GF12313@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818100151.GF12313@vanheusden.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 12:01:52PM +0200, Folkert van Heusden wrote:
> What about a zero-copy read-interface?
> An ioctl (or something) which enables the kernel to do dma directly to
> the userspace. Of course this should be limited to the root-user or a
> user with special capabilities (rights) since if a drive screws up, data
> from a different sector (or so) might end up in the proces' memory. Of
> course copying a sector from kernel- to userspace can be done pretty
> fast but i.m.h.o. all possible speedimprovements should be made unless
> unclean.

It's called O_DIRECT, and doesn't need root, just some alignment-constraints.

