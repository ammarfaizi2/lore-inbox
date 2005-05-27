Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVE0Taj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVE0Taj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVE0T3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:29:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1260 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262553AbVE0T30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:29:26 -0400
Date: Fri, 27 May 2005 20:29:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
Message-ID: <20050527192925.GA8250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <4297746C.10900@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4297746C.10900@ammasso.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:26:36PM -0500, Timur Tabi wrote:
> I have a driver that calls __pa() on an address obtained via vmalloc().  
> This is not supposed to work, and yet oddly it appears to.  Is there a 
> possibility, even a remote one, that __pa() will return the correct 
> physical address for a buffer returned by the vmalloc() function?

It will return the correct physical address for the start of the buffer.
But given that vmalloc is a non-contingous allocator that's pretty useless.

As are physical addresses for anything but low-level architecture code.

